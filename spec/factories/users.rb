FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    description { "Lorem ipsum dolor sit amet, consectetur adipiscing elit." }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
end
end
