require_relative "lib/quarterdeck/version"

Gem::Specification.new do |spec|
  spec.name        = "quarterdeck"
  spec.version     = Quarterdeck::VERSION
  spec.authors     = [ "leopolicastro" ]
  spec.email       = [ "43428385+leopolicastro@users.noreply.github.com" ]
  spec.homepage    = "https://github.com/leopolicastro/quarterdeck"
  spec.summary     = "Analytics dashboard engine for Rails apps using Ahoy"
  spec.description = "A beautiful analytics dashboard UI for Rails apps already using ahoy_matey for tracking. Quarterdeck reads your existing Ahoy data and presents it in a modern dashboard with charts, tables, and filters."
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/leopolicastro/quarterdeck"
  spec.metadata["changelog_uri"] = "https://github.com/leopolicastro/quarterdeck/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 8.1.2"
  spec.add_dependency "pagy", ">= 6"
  spec.add_dependency "groupdate", ">= 6"
  spec.add_dependency "csv"
end
