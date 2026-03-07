module Matey
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      desc "Install Matey analytics dashboard"

      def create_initializer
        create_file "config/initializers/matey.rb", <<~RUBY
          # Matey configuration
          # See https://github.com/leopolicastro/matey for documentation

          # Set the parent controller for Matey controllers
          # Matey.parent_controller = "ApplicationController"

          # Set up authentication (optional)
          # Matey.authenticate_with do
          #   redirect_to main_app.root_path unless current_user&.admin?
          # end
        RUBY
      end

      def mount_engine
        route 'mount Matey::Engine => "/analytics"'
      end

      def show_post_install
        say ""
        say "Matey has been installed!", :green
        say ""
        say "  Dashboard: /analytics"
        say "  Config:    config/initializers/matey.rb"
        say ""
        say "Make sure you have ahoy_matey configured in your app."
        say ""
      end
    end
  end
end
