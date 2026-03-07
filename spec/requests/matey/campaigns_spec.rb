require "rails_helper"

RSpec.describe "Matey::Campaigns", type: :request do
  before do
    Matey.instance_variable_set(:@authentication_block, nil)
  end

  let!(:visit) do
    Ahoy::Visit.create!(
      visit_token: SecureRandom.uuid,
      visitor_token: SecureRandom.uuid,
      started_at: 1.day.ago,
      utm_source: "google",
      utm_medium: "cpc",
      utm_campaign: "spring_sale",
      utm_term: "shoes",
      utm_content: "banner_ad"
    )
  end

  describe "GET /analytics/campaigns" do
    it "returns success" do
      get "/analytics/campaigns"
      expect(response).to have_http_status(:ok)
    end

    it "displays UTM breakdowns" do
      get "/analytics/campaigns"
      expect(response.body).to include("google")
      expect(response.body).to include("cpc")
      expect(response.body).to include("spring_sale")
    end
  end
end
