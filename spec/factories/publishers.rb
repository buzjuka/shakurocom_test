FactoryBot.define do
  factory :publisher do
    name Faker::Book.publisher
    access_token SecureRandom.uuid
  end
end
