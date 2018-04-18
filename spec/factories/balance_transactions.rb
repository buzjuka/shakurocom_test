FactoryBot.define do
  factory :balance_transaction do
    association :book_shop_balance
    amount { rand(1..4) }

    trait :sale do
      transaction_type BalanceTransaction.transaction_types[:sale]

      after(:create) do |transaction|
        transaction.book_shop_balance.update(sold_count: transaction.amount)
      end
    end
  end
end
