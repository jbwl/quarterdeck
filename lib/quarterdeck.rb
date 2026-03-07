require "quarterdeck/version"
require "ahoy_matey"
require "pagy"
require "groupdate"
require "quarterdeck/engine"

module Quarterdeck
  mattr_accessor :parent_controller, default: "ApplicationController"

  class << self
    def authenticate_with(&block)
      @authentication_block = block
    end

    def authentication_block
      @authentication_block
    end
  end
end
