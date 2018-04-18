class BookShopBalance < ApplicationRecord
  belongs_to :book
  belongs_to :shop
  has_many :balance_transactions, dependent: :destroy

  scope :for_ids, ->(ids) { where(id: ids) }
  scope :with_book_title, -> { joins(:book).select('book_shop_balances.*, books.title') }
end
