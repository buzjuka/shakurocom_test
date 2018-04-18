class Shop < ApplicationRecord
  include Authorizable

  has_many :book_shop_balances, dependent: :restrict_with_error
  has_many :books, through: :book_shop_balances

  scope :selling_book_for, ->(publisher_id) do
    with_in_stock_ids(publisher_id)
      .joins(:books)
      .where(books: { publisher_id: publisher_id })
      .where('book_shop_balances.sold_count > 0')
      .select('shops.*, sum(book_shop_balances.sold_count)::integer as books_sold_count')
      .order('books_sold_count')
      .group(:id)
  end
  scope :with_in_stock_ids, ->(publisher_id) do
    sql = with_positive_balance_ids(publisher_id).to_sql
    joins("left outer join (#{sql}) as balance_ids on balance_ids.id = shops.id")
      .select('coalesce(array_agg(distinct balance_ids.in_stock_balance_ids) '\
              'filter (where balance_ids.in_stock_balance_ids is not NULL), array[]::integer[]) '\
              'as in_stock_balance_ids')
  end

  scope :with_positive_balance_ids, ->(publisher_id) do
    joins('inner join book_shop_balances as positive_balances on shops.id = positive_balances.shop_id '\
          'inner join books as positive_books on positive_books.id = positive_balances.book_id')
      .where('positive_balances.stock_count > 0 and positive_books.publisher_id = ?', publisher_id)
      .select('array_agg(positive_balances.id) as in_stock_balance_ids, shops.id')
      .group(:id)
  end
end
