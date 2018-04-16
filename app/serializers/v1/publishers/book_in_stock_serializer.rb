module V1
  module Publishers
    class BookInStockSerializer < ActiveModel::Serializer
      attribute :book_id, key: :id
      attribute :title
      attribute :stock_count, key: :copies_in_stock
    end
  end
end
