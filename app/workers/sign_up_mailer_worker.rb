class SignUpMailerWorker
  include Sidekiq::Worker

  def perform attendee_id
    attendee = Attendee.find_by(id: attendee_id)
    return unless attendee

    ActionMailer::Base.mail(
      from: "me@coinhouse.com",
      to: attendee.user.email,
      subject: "Thanks for signin up !",
      body: "Hooray, you signed up"
    ).deliver
  end
end
