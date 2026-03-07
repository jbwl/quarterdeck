require "rails_helper"

RSpec.describe "Matey::Visits", type: :request do
  before do
    Matey.instance_variable_set(:@authentication_block, nil)
  end

  let!(:visit) do
    Ahoy::Visit.create!(
      visit_token: SecureRandom.uuid,
      visitor_token: SecureRandom.uuid,
      started_at: 1.day.ago,
      browser: "Firefox",
      os: "Linux",
      device_type: "Desktop",
      country: "DE",
      landing_page: "/about",
      referring_domain: "bing.com",
      ip: "1.2.3.4"
    )
  end

  describe "GET /analytics/visits" do
    it "returns success" do
      get "/analytics/visits"
      expect(response).to have_http_status(:ok)
    end

    it "displays the visits table" do
      get "/analytics/visits"
      expect(response.body).to include("Firefox")
      expect(response.body).to include("/about")
    end

    it "filters by browser" do
      get "/analytics/visits", params: { browser: "Firefox" }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Firefox")
    end

    it "filters by search" do
      get "/analytics/visits", params: { search: "about" }
      expect(response).to have_http_status(:ok)
    end

    it "filters by country" do
      get "/analytics/visits", params: { country: "DE" }
      expect(response).to have_http_status(:ok)
    end

    it "filters utm_only" do
      get "/analytics/visits", params: { utm_only: "1" }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /analytics/visits/:id" do
    it "returns success" do
      get "/analytics/visits/#{visit.id}"
      expect(response).to have_http_status(:ok)
    end

    it "shows visit details" do
      get "/analytics/visits/#{visit.id}"
      expect(response.body).to include("Visit Details")
      expect(response.body).to include("Firefox")
      expect(response.body).to include("Linux")
    end
  end
end
