require "rails_helper"

RSpec.describe Mutations::DeleteAttendeeMutation do
  describe "deleteAttendee" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:event) { FactoryBot.create(:event) }
    let!(:attendee) { FactoryBot.create(:attendee, user: user, event: event) }

    let(:query) do
      %(mutation deleteAttendee {
        deleteAttendee(
          input:{
            eventId: #{event.id},
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
      CoinhouseReservationSchema.execute(query, context: {current_user: user}).as_json
    end

    it "returns deleted attendee" do
      expect(result.dig("data", "deleteAttendee", "attendee", "event", "name")).to eq event.name
      expect(result.dig("data", "deleteAttendee", "attendee", "user", "name")).to eq user.name
    end
  end
end
