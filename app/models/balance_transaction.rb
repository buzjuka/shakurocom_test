class BalanceTransaction < ApplicationRecord
  enum transaction_type: { supply: 0, sale: 1, refund: 2 }

  belongs_to :book_shop_balance
end
