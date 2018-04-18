module V1
  module Shops
    class BaseController < ::V1::BaseController
      protected

      def current_user
        return @current_user if defined? @current_user
        @current_user = Shop.authorize(request.headers['Access-Token'])
      end
    end
  end
end
