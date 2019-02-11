class Attendance < ApplicationRecord
  belongs_to :attendee, class_name: "User"
  belongs_to :event
  validates :stripe_customer_id,
  presence: true
end
