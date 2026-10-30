require "rails"

require "css-zero"
require "importmap-rails"
require "stimulus-rails"
require "ahoy_matey"
require "pagy"
require "groupdate"

require "quarterdeck/css_zero/version"
require "quarterdeck/css_zero/engine"

module Quarterdeck
  module CssZero
    # Deprecated: kept only so initializers written for the original gem
    # (`Quarterdeck.parent_controller = "ApplicationController"`) do not raise.
    # Quarterdeck CssZero is self-contained and always renders its own CSS Zero
    # layout, so this setting has no effect.
    mattr_accessor :parent_controller

    class << self
      def authenticate_with(&block)
        @authentication_block = block
      end

      def authentication_block
        @authentication_block
      end
    end
  end
end
