FactoryBot.define do
  factory :user do
    # Use sequence to make sure that the value is unique
    sequence(:email) { |n| "coinhouse-#{Faker::Internet.user_name}#{n}@coinhouse.fr" }
    password {'password'}
    name { Faker::Name.first_name }
  end

  factory :event do
    name { Faker::Lorem.characters(number: 10) }
    description { Faker::Lorem.characters(number: 10) }
    location { Faker::Address.city }
    happens_on { Faker::Date.between(from: 2.days.ago, to: Date.today) }
    starts_at { happens_on.to_datetime.beginning_of_day + 9.hours }
    ends_at { happens_on.to_datetime.beginning_of_day + 10.hours }
    user
  end

  factory :workshop, parent: :event, class: 'Workshop' do
    max_attendees { 5 }
  end

  factory :office_hour, parent: :event, class: 'OfficeHour' do
  end

  factory :attendee do
    user
    event { FactoryBot.create :workshop}
  end
end
