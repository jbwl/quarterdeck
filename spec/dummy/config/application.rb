require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)
require "quarterdeck"

module Dummy
  class Application < Rails::Application
    config.root = File.expand_path("..", __dir__)
    config.eager_load = false
    config.active_support.deprecation = :stderr
  end
end
