FactoryBot.define do
  factory :shop do
    name Faker::Company.name
    access_token SecureRandom.uuid
  end
end
