require "rails_helper"

RSpec.describe Mutations::AddAttendeeMutation do
  describe "addAttendee" do
    let!(:workshop) { FactoryBot.create(:workshop) }
    let!(:user) { FactoryBot.create(:user) }

    let(:query) do
      %(mutation addAttendee {
        addAttendee(
          input:{
            eventId: #{Event.first.id},
          }) {
          attendee{
            event{
              name
            }
            user{
              name
            }
          }
          errors
        }

      })
    end

    subject(:result) do
      CoinhouseReservationSchema.execute(query, context: {current_user: User.last}).as_json
    end

    it "returns newly created attendee" do
      expect(result.dig("data", "addAttendee", "attendee", "event", "name")).to eq Event.last.name
      expect(result.dig("data", "addAttendee", "attendee", "user", "name")).to eq User.last.name
    end
  end
end
