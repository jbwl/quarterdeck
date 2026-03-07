require "rails_helper"

RSpec.describe Matey do
  after do
    Matey.parent_controller = "ApplicationController"
    Matey.authenticate_with { } # reset
    Matey.instance_variable_set(:@authentication_block, nil)
  end

  describe ".parent_controller" do
    it "defaults to ApplicationController" do
      expect(Matey.parent_controller).to eq("ApplicationController")
    end

    it "can be configured" do
      Matey.parent_controller = "AdminController"
      expect(Matey.parent_controller).to eq("AdminController")
    end
  end

  describe ".authenticate_with" do
    it "stores an authentication block" do
      Matey.authenticate_with { "authenticated" }
      expect(Matey.authentication_block).to be_a(Proc)
    end

    it "returns nil when no block is configured" do
      Matey.instance_variable_set(:@authentication_block, nil)
      expect(Matey.authentication_block).to be_nil
    end
  end
end
