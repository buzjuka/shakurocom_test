class CreateBookShopBalances < ActiveRecord::Migration[5.0]
  def change
    create_table :book_shop_balances do |t|
      t.bigint :sold_count, default: 0, null: false
      t.bigint :stock_count, default: 0, null: false
      t.references :book, foreign_key: true
      t.references :shop, foreign_key: true

      t.timestamps
    end
  end
end
