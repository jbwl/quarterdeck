module Matey
  class Engine < ::Rails::Engine
    isolate_namespace Matey

    initializer "matey.importmap", before: "importmap" do |app|
      if app.config.respond_to?(:importmap)
        app.config.importmap.paths << Engine.root.join("config/importmap.rb")
        app.config.importmap.cache_sweepers << Engine.root.join("app/javascript")
      end
    end

    initializer "matey.assets" do |app|
      app.config.assets.precompile += %w[ matey/application.css ] if app.config.respond_to?(:assets)
    end

  end
end
