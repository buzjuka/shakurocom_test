class Book < ApplicationRecord
  belongs_to :publisher
  has_many :book_shop_balances, dependent: :restrict_with_error
end
