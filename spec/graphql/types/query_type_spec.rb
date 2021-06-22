require "rails_helper"

RSpec.describe Types::QueryType do
  describe "events" do
    let!(:events) { create_pair(:event) }

    let(:query) do
      %(query {
        events {
          name
        }
      })
    end

    subject(:result) do
      CoinhouseReservationSchema.execute(query).as_json
    end

    it "returns all items" do
      expect(result.dig("data", "events")).to match_array(
        events.map { |event| { "name" => event.name } }
      )
    end
  end
end
