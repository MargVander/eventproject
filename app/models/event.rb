class Event < ApplicationRecord

  validates :start_date , presence: true
  validate  :start_date_cannot_be_in_the_past
  validates :title, presence: true, length: { minimum: 3, maximum: 140 }
  validates :location , presence: true
  validates :description, presence: true, length: { minimum: 3, maximum: 1000 }
  validates :price, presence: true, numericality: { only_integer: true }, numericality: { greater_than: 0, less_than_or_equal_to: 1000 }
  validates :duration , presence: true , numericality: { only_integer: true }
  validate  :multiple_of_5?


  belongs_to :admin , class_name: "User"
  has_many :attendances
  has_many :attendees, class_name: "User", through: :attendances


  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "can't be in the past")
    end
  end

  def multiple_of_5?
    if duration % 5 == 0
      return true
    else
      errors.add(:duration, "must be a multiple of 5")
    end
  end
end
