class Publisher < ApplicationRecord
  include Authorizable

  has_many :books, dependent: :restrict_with_error
end
