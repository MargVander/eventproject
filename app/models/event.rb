class Event < ApplicationRecord
  belongs_to :admin, class_name: "User"
  has_many :attendances
  has_many :attendees, through: :attendances
  has_one_attached :picture
  validates :start_date, presence: true
  validates :duration, presence: true, numericality: { only_integer: true }#,  if: :multiple_of_5
  validates :title,
    presence: true,
    length: { in: 5..140 }
  validates :description,
    presence: true,
    length: { in: 20..100 }
  validates :price,
    presence: true,
    length: { in: 1..1000 }
  validates :location,
    presence: true
  validate :future
  validate :multiple_of_5?


  def future
    if start_date.present? && start_date < DateTime.now
        errors.add(:start_date, "can't be in the past")
    end
  end

  def multiple_of_5?
    if duration % 5 == 0
      return true
    else
      errors.add(:duration, "it should be a multiple of 5")
    end
  end
end
