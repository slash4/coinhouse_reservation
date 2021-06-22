require "rails_helper"

RSpec.describe Resolvers::EventsSearch do
  describe "events" do
    let!(:event1) { FactoryBot.create :event }
    let!(:event2) { FactoryBot.create :event }
    let!(:event3) { FactoryBot.create :event }
    let!(:event4) { FactoryBot.create :event }

    let(:query) do
      %(query {
        events(filter: {locationContains: "#{event3.location}"}) {
          name
        }
      })
    end

    subject(:result) do
      CoinhouseReservationSchema.execute(query).as_json
    end

    it "returns matching items" do
      expect(result.dig("data", "events")).to match_array(
        [event3].map { |event| { "name" => event.name } }
      )
    end
  end
end

