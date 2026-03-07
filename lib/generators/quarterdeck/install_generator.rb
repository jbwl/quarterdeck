module Quarterdeck
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      desc "Install Quarterdeck analytics dashboard"

      def create_initializer
        create_file "config/initializers/quarterdeck.rb", <<~RUBY
          # Quarterdeck configuration
          # See https://github.com/leopolicastro/quarterdeck for documentation

          # Set the parent controller for Quarterdeck controllers
          # Quarterdeck.parent_controller = "ApplicationController"

          # Set up authentication (optional)
          # Quarterdeck.authenticate_with do
          #   redirect_to main_app.root_path unless current_user&.admin?
          # end
        RUBY
      end

      def mount_engine
        route 'mount Quarterdeck::Engine => "/analytics"'
      end

      def show_post_install
        say ""
        say "Quarterdeck has been installed!", :green
        say ""
        say "  Dashboard: /analytics"
        say "  Config:    config/initializers/quarterdeck.rb"
        say ""
        say "Make sure you have ahoy_matey configured in your app."
        say ""
      end
    end
  end
end
