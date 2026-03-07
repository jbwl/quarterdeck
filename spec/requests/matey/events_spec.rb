require "rails_helper"

RSpec.describe "Matey::Events", type: :request do
  before do
    Matey.instance_variable_set(:@authentication_block, nil)
  end

  let!(:visit) do
    Ahoy::Visit.create!(
      visit_token: SecureRandom.uuid,
      visitor_token: SecureRandom.uuid,
      started_at: 1.day.ago
    )
  end

  let!(:event) do
    Ahoy::Event.create!(
      visit: visit,
      name: "button_click",
      properties: { "label" => "signup" },
      time: 1.day.ago
    )
  end

  describe "GET /analytics/events" do
    it "returns success" do
      get "/analytics/events"
      expect(response).to have_http_status(:ok)
    end

    it "displays event stats" do
      get "/analytics/events"
      expect(response.body).to include("Total Events")
      expect(response.body).to include("button_click")
    end

    it "filters by event name" do
      get "/analytics/events", params: { name: "button_click" }
      expect(response).to have_http_status(:ok)
    end
  end
end
