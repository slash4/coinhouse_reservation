require "rails_helper"

RSpec.describe Mutations::SignInMutation do
  describe "signIn" do
    let!(:user) { FactoryBot.create(:user) }

    let(:query) do
      %(mutation signIn {
          signIn(email: "#{user.email}", password: "#{user.password}"){
            token
            user{
              name
            }
          }
        })
    end

    subject(:result) do
      CoinhouseReservationSchema.execute(query).as_json
    end

    it "returns token" do
      expect(result.dig("data", "signIn", "user", "name")).to eq user.name
      expect(result.dig("data", "signIn", "token")).not_to be nil
    end
  end
end
