require "rails_helper"

RSpec.describe "Matey Authentication", type: :request do
  after do
    Matey.instance_variable_set(:@authentication_block, nil)
  end

  it "allows access when no authentication is configured" do
    Matey.instance_variable_set(:@authentication_block, nil)
    get "/analytics"
    expect(response).to have_http_status(:ok)
  end

  it "runs the authentication block" do
    Matey.authenticate_with do
      head :forbidden
    end

    get "/analytics"
    expect(response).to have_http_status(:forbidden)
  end
end
