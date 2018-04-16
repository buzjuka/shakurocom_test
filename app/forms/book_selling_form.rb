class BookSellingForm < BaseForm
  TRANSACTION_ATTRS = %i[amount].freeze

  delegate :amount, to: :balance_transaction

  validates :amount, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :check_stock

  def self.permit_params
    TRANSACTION_ATTRS
  end

  def initialize(book_id, shop_id)
    @book_shop_balance = BookShopBalance.find_by!(book_id: book_id, shop_id: shop_id)
  end

  private

  attr_reader :book_shop_balance

  def balance_transaction
    @balance_transaction ||= book_shop_balance.balance_transactions.build(
      transaction_type: BalanceTransaction.transaction_types[:sale]
    )
  end

  def assign_params(params)
    balance_transaction.attributes = params.slice(*TRANSACTION_ATTRS)
  end

  def save_form!
    ActiveRecord::Base.transaction do
      balance_transaction.save!
      update_balance!
    end
  end

  def update_balance!
    book_shop_balance.sold_count += amount
    book_shop_balance.stock_count -= amount
    book_shop_balance.save!
  end

  def check_stock
    errors.add(:amount, :luck_of_stock) if amount && book_shop_balance.stock_count < amount
  end
end
