module Quarterdeck
  class Engine < ::Rails::Engine
    isolate_namespace Quarterdeck

    # Register the engine's importmap. Merged into the host application's
    # importmap, but consumed only by the engine's own layout via
    # `javascript_importmap_tags("quarterdeck/application")`.
    initializer "quarterdeck.importmap", before: "importmap" do |app|
      if app.config.respond_to?(:importmap)
        app.config.importmap.paths << Engine.root.join("config/importmap.rb")
        app.config.importmap.cache_sweepers << Engine.root.join("app/javascript")
      end
    end

    # Make the engine's stylesheets, images and vendored JavaScript available
    # to the asset pipeline (Propshaft/Sprockets).
    initializer "quarterdeck.assets" do |app|
      if app.config.respond_to?(:assets)
        app.config.assets.paths << Engine.root.join("app/javascript")
      end
    end
  end
end
