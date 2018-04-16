module V1
  class BaseController < ApplicationController
    before_action :authorize!

    rescue_from ActiveRecord::RecordNotFound do
      head :not_found
    end

    protected

    def authorize!
      return head :unauthorized unless current_user
    end

    def render_errors(object)
      render json: { errors: prepare_errors_from(object) }, status: :unprocessable_entity
    end

    def prepare_errors_from(object)
      object.errors.to_hash.map { |k, v| { field: k, errors: v }}
    end

    def current_user
      raise NotImplementedError
    end
  end
end
