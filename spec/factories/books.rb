FactoryBot.define do
  factory :book do
    title Faker::Book.title
    association :publisher

    trait :with_balances do
      transient do
        shops [create(:shop)]
      end

      after(:create) do |book, evaluator|
        evaluator.shops.each do |shop|
          create(:book_shop_balance, shop: shop, book: book)
        end
      end
    end
  end
end
