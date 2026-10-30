require "rails_helper"

RSpec.describe Quarterdeck do
  after do
    Quarterdeck.parent_controller = nil
    Quarterdeck.instance_variable_set(:@authentication_block, nil)
  end

  describe ".parent_controller (deprecated)" do
    it "is a no-op accessor kept for backwards compatibility" do
      expect(Quarterdeck.parent_controller).to be_nil
      expect { Quarterdeck.parent_controller = "ApplicationController" }.not_to raise_error
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
