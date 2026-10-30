require "rails_helper"

RSpec.describe "Quarterdeck self-contained layout", type: :request do
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

  let!(:event) do
    Ahoy::Event.create!(visit: visit, name: "$view", properties: { "url" => "/home" }, time: 1.day.ago)
  end

  it "renders the CSS Zero layout without any host layout assets" do
    get "/analytics"
    expect(response).to have_http_status(:ok)
    expect(response.body).to include("css-zero/reset")
    expect(response.body).to include("css-zero/variables")
    expect(response.body).to include("quarterdeck")
    expect(response.body).to include("css-zero/utilities")
  end

  it "loads the engine's own importmap entrypoint" do
    get "/analytics"
    expect(response.body).to include(%(type="importmap"))
    expect(response.body).to include("quarterdeck-csszero/application")
  end

  it "uses no CDN assets" do
    get "/analytics"
    expect(response.body).not_to include("cdn.tailwindcss.com")
    expect(response.body).not_to include("cdn.jsdelivr.net")
  end

  it "wires charts to the engine chart controller" do
    get "/analytics"
    expect(response.body).to include(%(data-controller="chart"))
    expect(response.body).to include(%(data-chart-type-value="line"))
  end
end
