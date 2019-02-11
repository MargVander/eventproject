FactoryBot.define do
  factory :attendance do
    event {FactoryBot.create(:event)}
    attendee {FactoryBot.create(:user)}
  end
end
