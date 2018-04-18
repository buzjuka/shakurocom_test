raise 'You launch seeds in non development environment' unless Rails.env.development?

shops = (0..1).map { Shop.create!(name: Faker::Company.unique.name) }
publishers = (0..1).map { Publisher.create!(name: Faker::Book.unique.publisher) }
books = []
publishers.each do |publisher|
  3.times do
    book = publisher.books.create!(title: Faker::Book.unique.title)
    balance = shops.sample.book_shop_balances.create!(stock_count: rand(4), book: book)
    balance.balance_transactions.create!(amount: balance.stock_count)
  end
end
