module V1
  module Publishers
    module ShopsQueryService
      module_function

      def perform(publisher, params)
        shops_with_selling = Shop.selling_book_for(publisher).page(params[:page])
        balance_ids = shops_with_selling.map(&:in_stock_balance_ids).flatten
        book_balances = BookShopBalance.for_ids(balance_ids).with_book_title.map { |book| [book.id, book] }.to_h
        ActiveModelSerializers::SerializableResource.new(
          shops_with_selling,
          each_serializer: ShopSerializer,
          balances_with_stock: book_balances
        ).to_json
      end
    end
  end
end
