module Quarterdeck
  class Engine < ::Rails::Engine
    isolate_namespace Quarterdeck

    initializer "quarterdeck.importmap", before: "importmap" do |app|
      if app.config.respond_to?(:importmap)
        app.config.importmap.paths << Engine.root.join("config/importmap.rb")
        app.config.importmap.cache_sweepers << Engine.root.join("app/javascript")
      end
    end

    initializer "quarterdeck.assets" do |app|
      if app.config.respond_to?(:assets)
        app.config.assets.paths << Engine.root.join("app/javascript")
        app.config.assets.precompile += %w[ quarterdeck/application.css ]
      end
    end
  end
end
