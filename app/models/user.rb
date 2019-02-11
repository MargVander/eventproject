class User < ApplicationRecord
  after_create :welcome_send

  has_many :events, foreign_key: 'admin_id', class_name: "Event"
  has_many :attendances, foreign_key: 'attendee_id', class_name: "Attendance"
  has_many :events, through: :attendances
  validates :email,
    presence: true,
    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "email adress please" }


  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end


end
