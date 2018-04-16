FactoryBot.define do
  factory :book_shop_balance do
    association :book
    association :shop
    stock_count { rand(1..8) }

    after(:create) do |balance|
      create(:balance_transaction, amount: balance.stock_count, book_shop_balance: balance)
    end
  end
end
