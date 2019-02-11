class Event < ApplicationRecord
  belongs_to :admin, class_name: "User"
  has_many :attendances
  has_many :attendees, through: :attendances
  validates :start_date,
    presence: true
    #if: :future true
  validates :duration,
    presence: true
    #if: :multiple_of_5 true
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


  def future
    if start_date > Time.now
      return true
    else
      return false
    end
  end


  def multiple_of_5
    if duration % 5 == 0
      return true
    else
      return false
    end
  end



end
