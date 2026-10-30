require "rails_helper"

RSpec.describe "Quarterdeck::CssZero::TopEvents", type: :request do
  before do
    Quarterdeck::CssZero.instance_variable_set(:@authentication_block, nil)
  end

  let!(:visit) do
    Ahoy::Visit.create!(
      visit_token: SecureRandom.uuid,
      visitor_token: SecureRandom.uuid,
      started_at: 1.day.ago
    )
  end

  let!(:events) do
    [
      [ "Catalog viewed", { "campaign_name" => "Spring", "catalog_name" => "Catalogue A" } ],
      [ "Catalog viewed", { "campaign_name" => "Spring", "catalog_name" => "Catalogue B" } ],
      [ "Catalog viewed", { "campaign_name" => "Summer", "catalog_name" => "Catalogue A" } ],
      [ "Newsletter viewed", { "campaign_name" => "Summer" } ]
    ].map do |name, properties|
      Ahoy::Event.create!(visit: visit, name: name, properties: properties, time: 1.day.ago)
    end
  end

  describe "GET /analytics/top_events" do
    it "returns success" do
      get "/analytics/top_events"
      expect(response).to have_http_status(:ok)
    end

    it "discovers the property keys from the events" do
      get "/analytics/top_events"
      expect(response.body).to include("campaign_name")
      expect(response.body).to include("catalog_name")
    end

    it "breaks down the first property by default" do
      get "/analytics/top_events"
      expect(response.body).to include("Breakdown by campaign_name")
      expect(response.body).to include("Spring")
      expect(response.body).to include("Summer")
    end

    it "breaks down the chosen property" do
      get "/analytics/top_events", params: { property: "catalog_name" }
      expect(response.body).to include("Breakdown by catalog_name")
      expect(response.body).to include("Catalogue A")
      expect(response.body).to include("Catalogue B")
    end

    it "scopes the breakdown by event name" do
      get "/analytics/top_events", params: { property: "catalog_name", name: "Newsletter viewed" }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("No data for this period")
    end

    it "renders a horizontal bar chart of the top entries" do
      get "/analytics/top_events"
      expect(response.body).to include("indexAxis")
      expect(response.body).to include("Top 2 by campaign_name")
    end

    it "falls back to the first property for an unknown property" do
      get "/analytics/top_events", params: { property: "not_a_property" }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Breakdown by campaign_name")
    end

    it "paginates the breakdown" do
      30.times do |i|
        Ahoy::Event.create!(
          visit: visit,
          name: "Paged",
          properties: { "page_slug" => "slug-#{i}" },
          time: 1.day.ago
        )
      end

      get "/analytics/top_events", params: { property: "page_slug" }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("page=2")
    end

    it "exports the breakdown as CSV" do
      get "/analytics/top_events.csv", params: { property: "campaign_name" }
      expect(response).to have_http_status(:ok)
      expect(response.headers["Content-Type"]).to include("text/csv")
      expect(response.body).to include("campaign_name,Events")
      expect(response.body).to include("Spring,2")
    end

    it "renders without properties on the events" do
      Ahoy::Event.delete_all
      Ahoy::Event.create!(visit: visit, name: "plain", properties: {}, time: 1.day.ago)

      get "/analytics/top_events"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("No event properties found for this period")
    end
  end
end
