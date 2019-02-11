class Attendance < ApplicationRecord
  after_create :new_attendee

  belongs_to :attendee, class_name: "User"
  belongs_to :event
  validates :stripe_customer_id, absence: true

  def new_attendee
    UserMailer.new_attendee_email(self).deliver_now
  end
end
