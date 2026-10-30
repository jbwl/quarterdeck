require "rails_helper"

RSpec.describe "Quarterdeck Authentication", type: :request do
  after do
    Quarterdeck::CssZero.instance_variable_set(:@authentication_block, nil)
  end

  it "allows access when no authentication is configured" do
    Quarterdeck::CssZero.instance_variable_set(:@authentication_block, nil)
    get "/analytics"
    expect(response).to have_http_status(:ok)
  end

  it "runs the authentication block" do
    Quarterdeck::CssZero.authenticate_with do
      head :forbidden
    end

    get "/analytics"
    expect(response).to have_http_status(:forbidden)
  end
end
