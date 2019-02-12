require 'faker'

10.times do
  user = User.create(email: Faker::Internet.email, description: Faker::Lorem.sentence, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: Faker::Internet.password)
end

5.times do
  event = Event.new(start_date: DateTime.now + 5.days, duration: 5, title: Faker::RuPaul.queen, description: Faker::Lorem.sentence, price: 5, location: Faker::Address.city)
  event.admin = User.all.sample
  event.save
end

10.times do
  attendance = Attendance.new
  attendance.event = Event.all.sample
  attendance.attendee = User.all.sample
  attendance.save
end
