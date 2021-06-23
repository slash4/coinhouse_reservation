class Event < ApplicationRecord
  belongs_to :user
  has_many :attendees

  def remaining_seats
    nil
  end
end

