class EventEndsMailerWorker
  include Sidekiq::Worker

  def perform attendee_id
    attendee = Attendee.find_by(id: attendee_id)
    return unless attendee

    ActionMailer::Base.mail(
      from: "me@coinhouse.com",
      to: attendee.user.email,
      subject: "Your event just ended !",
      body: "How was it ? Thanks for using our service."
    ).deliver
  end
end
