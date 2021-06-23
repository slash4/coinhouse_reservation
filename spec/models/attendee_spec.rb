require 'rails_helper'

RSpec.describe Attendee, type: :model do

  it 'sends mails' do
    Sidekiq::Testing.inline! do
      attendee = FactoryBot.create(:attendee)
      expect(ActionMailer::Base.deliveries.count).to eq 3
    end
  end

  it 'schedules mails' do
    Sidekiq::Testing.fake! do
      attendee = FactoryBot.create(:attendee)
      expect(DayBeforeMailerWorker.jobs.size).to eq 1
      expect(EventEndsMailerWorker.jobs.size).to eq 1
    end
  end
end
