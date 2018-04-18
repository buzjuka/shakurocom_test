class CreateBalanceTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :balance_transactions do |t|
      t.integer :transaction_type, default: 0, null: false
      t.integer :amount, null: false
      t.references :book_shop_balance, foreign_key: true

      t.timestamps
    end
  end
end
