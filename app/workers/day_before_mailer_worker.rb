class DayBeforeMailerWorker
  include Sidekiq::Worker

  def perform attendee_id
    attendee = Attendee.find_by(id: attendee_id)
    return unless attendee

    ActionMailer::Base.mail(
      from: "me@coinhouse.com",
      to: attendee.user.email,
      subject: "Your event will happen tomorrow !",
      body: "Are you impatient ?"
    ).deliver
  end
end
