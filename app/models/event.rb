class Event < ApplicationRecord
  belongs_to :user
  has_many :attendees, dependent: :destroy

  validate :check_dates_and_hours

  def check_dates_and_hours
    if (happens_on.to_datetime > starts_at) || (starts_at > happens_on.to_datetime + 24.hours)
      errors.add(:starts_at, "must be the same day than happens_on")
    end
    if (ends_at < starts_at) || (ends_at > happens_on.to_datetime + 24.hours)
      errors.add(:ends_at, "must be the same day than happens_on, and > starts_at")
    end
  end

  def remaining_seats
    nil
  end
end

