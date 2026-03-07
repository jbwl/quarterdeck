module Matey
  class Engine < ::Rails::Engine
    isolate_namespace Matey

    initializer "matey.importmap", before: "importmap" do |app|
      app.config.importmap.paths << Engine.root.join("config/importmap.rb")
      app.config.importmap.cache_sweepers << Engine.root.join("app/javascript")
    end

    initializer "matey.assets" do |app|
      app.config.assets.precompile += %w[ matey/application.css ] if app.config.respond_to?(:assets)
    end

    initializer "matey.helpers" do
      ActiveSupport.on_load(:action_controller_base) do
        helper Pagy::Frontend if defined?(Pagy::Frontend)
      end
    end
  end
end
