module V1
  module Publishers
    class ShopsController < BaseController
      def index
        render json: ShopsQueryService.perform(current_user, params)
      end
    end
  end
end
