require "rails_helper"

RSpec.describe Quarterdeck do
  after do
    Quarterdeck.parent_controller = "ApplicationController"
    Quarterdeck.authenticate_with { } # reset
    Quarterdeck.instance_variable_set(:@authentication_block, nil)
  end

  describe ".parent_controller" do
    it "defaults to ApplicationController" do
      expect(Quarterdeck.parent_controller).to eq("ApplicationController")
    end

    it "can be configured" do
      Quarterdeck.parent_controller = "AdminController"
      expect(Quarterdeck.parent_controller).to eq("AdminController")
    end
  end

  describe ".authenticate_with" do
    it "stores an authentication block" do
      Quarterdeck.authenticate_with { "authenticated" }
      expect(Quarterdeck.authentication_block).to be_a(Proc)
    end

    it "returns nil when no block is configured" do
      Quarterdeck.instance_variable_set(:@authentication_block, nil)
      expect(Quarterdeck.authentication_block).to be_nil
    end
  end
end
