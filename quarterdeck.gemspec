require_relative "lib/quarterdeck/css_zero/version"

Gem::Specification.new do |spec|
  spec.name        = "quarterdeck-csszero"
  spec.version     = Quarterdeck::CssZero::VERSION
  spec.authors     = [ "BL", "leopolicastro" ]
  spec.email       = [ "mercies.latter-8w@icloud.com", "43428385+leopolicastro@users.noreply.github.com" ]
  spec.homepage    = "https://github.com/jbwl/quarterdeck"
  spec.summary     = "Self-contained analytics dashboard engine for Rails apps using Ahoy"
  spec.description = "A no-build, self-contained analytics dashboard engine for Rails 8.1+ apps " \
                     "already using ahoy_matey for tracking. Quarterdeck reads your existing Ahoy " \
                     "data and presents it in a dashboard styled entirely with CSS Zero (>= 4.3.0), " \
                     "with no dependency on the host app's layout, CSS or JavaScript."
  spec.license     = "MIT"
  spec.required_ruby_version = ">= 3.2"

  spec.metadata["homepage_uri"]  = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  # This gem is a maintained, CSS Zero-native continuation of the original
  # "quarterdeck" gem by leopolicastro.
  spec.metadata["original_gem"]    = "quarterdeck"
  spec.metadata["original_author"] = "leopolicastro"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md", "CHANGELOG.md", "CREDITS.md"]
  end

  spec.add_dependency "rails", ">= 8.1.2"
  spec.add_dependency "ahoy_matey", ">= 4"
  spec.add_dependency "css-zero", ">= 4.3.0"
  spec.add_dependency "importmap-rails"
  spec.add_dependency "stimulus-rails"
  spec.add_dependency "pagy", ">= 43"
  spec.add_dependency "groupdate", ">= 6"
  spec.add_dependency "csv"
end
