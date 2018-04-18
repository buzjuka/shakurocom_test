module Authorizable
  extend ActiveSupport::Concern

  included do
    def self.authorize(access_token)
      find_by(access_token: access_token)
    end
  end
end
