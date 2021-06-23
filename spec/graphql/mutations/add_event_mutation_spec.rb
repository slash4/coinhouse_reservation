require "rails_helper"

RSpec.describe Mutations::AddEventMutation do
  describe "addEvent" do
    let!(:user) { FactoryBot.create(:user) }

    let(:query) do
      %(mutation addEvent {
        addEvent(
          input:{
            userId: #{User.first.id},
            type: "OfficeHour",
            description: "again description",
            location: "location",
            name: "name",
            happensOn: 1624379395,
            startsAt: 1624379495,
            endsAt: 1624379595
          }) {

          event{
            name
            startsAt
          }
          errors
        }

      })
    end

    subject(:result) do
      CoinhouseReservationSchema.execute(query, context: {current_user: User.first}).as_json
    end

    it "returns newly created event" do
      expect(result.dig("data", "addEvent", "event", "name")).to eq 'name'
    end
  end
end
