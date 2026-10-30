require "rails_helper"

RSpec.describe "Quarterdeck::CssZero::Geographics", type: :request do
  before do
    Quarterdeck::CssZero.instance_variable_set(:@authentication_block, nil)
  end

  let!(:visit) do
    Ahoy::Visit.create!(
      visit_token: SecureRandom.uuid,
      visitor_token: SecureRandom.uuid,
      started_at: 1.day.ago,
      country: "US",
      region: "California",
      city: "San Francisco"
    )
  end

  describe "GET /analytics/geographic" do
    it "returns success" do
      get "/analytics/geographic"
      expect(response).to have_http_status(:ok)
    end

    it "displays geographic breakdowns" do
      get "/analytics/geographic"
      expect(response.body).to include("US")
      expect(response.body).to include("California")
      expect(response.body).to include("San Francisco")
    end
  end
end
