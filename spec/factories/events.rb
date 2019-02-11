FactoryBot.define do
  factory :event do
    admin {FactoryBot.create(:user)}
    start_date { DateTime.now + 3.day}
    duration { 10 }
    title { "Lorem Ipsum" }
    description { "Lorem ipsum dolor sit amet, consectetur adipiscing elit." }
    price { rand(1..1000) }
    location { Faker::Address.city }
  end
end
