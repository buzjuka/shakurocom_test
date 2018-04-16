module V1
  module Shops
    class BookSellingsController < BaseController
      def create
        form = BookSellingForm.new(params.dig(:book_selling, :book_id), current_user.id)
        return head :created if form.submit(book_selling_params)
        render_errors(form)
      end

      private

      def book_selling_params
        params.require(:book_selling).permit(BookSellingForm.permit_params)
      end
    end
  end
end
