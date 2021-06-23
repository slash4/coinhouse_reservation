class Attendee < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates_uniqueness_of :event_id, scope: [:user_id]
  validate :no_more_seats

  def no_more_seats
    if (event.attendees.count >= (event.max_attendees || 1))
      errors.add(:event_id, "has reached its maximum number of attendees")
    end
  end
end
