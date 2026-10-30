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
    expect(response.body).to include("quarterdeck-csszero")
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

  it "uses the header layout with a desktop header menu and a mobile sheet menu" do
    get "/analytics"
    expect(response.body).to include(%(<body class="header-layout">))
    expect(response.body).to include(%(id="header"))
    expect(response.body).to include(%(id="main"))

    # Desktop header menu (analytics sections, hidden below md)
    expect(response.body).to include(%(show@md))
    expect(response.body).to include(%(aria-label="Analytics sections"))

    # Mobile menu button + left sheet
    expect(response.body).to include(%(data-controller="menu"))
    expect(response.body).to include(%(class="sheet sheet--left"))
    expect(response.body).to include(%(data-menu-target="panel"))

    # Every section is reachable from both menus
    %w[Overview Visits Events Top\ Events Campaigns Geographic Live].each do |section|
      expect(response.body.scan(section).size).to be >= 2
    end
  end
end
