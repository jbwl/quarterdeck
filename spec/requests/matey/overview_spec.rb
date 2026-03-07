require "rails_helper"

RSpec.describe "Matey::Overview", type: :request do
  before do
    Matey.instance_variable_set(:@authentication_block, nil)
  end

  let!(:visit) do
    Ahoy::Visit.create!(
      visit_token: SecureRandom.uuid,
      visitor_token: SecureRandom.uuid,
      started_at: 1.day.ago,
      browser: "Chrome",
      os: "macOS",
      device_type: "Desktop",
      country: "US",
      referring_domain: "google.com",
      landing_page: "/",
      utm_source: "newsletter"
    )
  end

  let!(:event) do
    Ahoy::Event.create!(
      visit: visit,
      name: "$view",
      properties: { "url" => "/home" },
      time: 1.day.ago
    )
  end

  describe "GET /analytics" do
    it "returns success" do
      get "/analytics"
      expect(response).to have_http_status(:ok)
    end

    it "displays visit stats" do
      get "/analytics"
      expect(response.body).to include("Total Visits")
      expect(response.body).to include("Unique Visitors")
      expect(response.body).to include("Total Events")
    end

    it "respects period parameter" do
      get "/analytics", params: { period: "today" }
      expect(response).to have_http_status(:ok)
    end

    it "displays navigation tabs" do
      get "/analytics"
      expect(response.body).to include("Overview")
      expect(response.body).to include("Visits")
      expect(response.body).to include("Events")
      expect(response.body).to include("Campaigns")
      expect(response.body).to include("Geographic")
    end
  end
end
