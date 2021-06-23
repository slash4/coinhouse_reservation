class Attendee < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates_uniqueness_of :event_id, scope: [:user_id]
  validate :no_more_seats

  after_create :schedule_mails

  def no_more_seats
    if (event.attendees.count >= (event.max_attendees || 1))
      errors.add(:event_id, "has reached its maximum number of attendees")
    end
  end

  def schedule_mails
    # This is far from perfect, as rescheduling tasks in redis is extremely painful.
    # I didn't pushed things too far here, as the idea was to have the simplest thing working.
    # In normal production conditions I would go for a cron task running every minute,
    # but it would be overkill here. If event is rescheduled, mails will be off. If event
    # is deleted, attendees will be deleted too and the worker won't send the mail.

    SignUpMailerWorker.perform_async(self.id)
    DayBeforeMailerWorker.perform_at((self.event.happens_on.to_datetime - 1.day), self.id)
    EventEndsMailerWorker.perform_at((self.event.ends_at + 1.hour), self.id)
  end
end
