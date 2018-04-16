module V1
  module Publishers
    class ShopSerializer < ::ShopSerializer
      attributes :books_sold_count, :books_in_stock

      def books_in_stock
        ActiveModelSerializers::SerializableResource.new(
          balances_with_stock,
          each_serializer: BookInStockSerializer,
          adapter: :attributes
        )
      end

      private

      def balances_with_stock
        instance_options[:balances_with_stock].slice(*object.in_stock_balance_ids.flatten).values
      end
    end
  end
end
