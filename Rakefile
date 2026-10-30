require "bundler/setup"
require "bundler/gem_tasks"

# Load the engine's rake tasks (e.g. quarterdeck:update_css_zero).
Dir[File.join(__dir__, "lib/tasks/**/*.rake")].each { |file| load file }

begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
  # rspec is only present in development/test
end
