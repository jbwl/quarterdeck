module Quarterdeck
  module CssZero
    module Generators
      class InstallGenerator < Rails::Generators::Base
        source_root File.expand_path("templates", __dir__)

        desc "Install the Quarterdeck analytics dashboard engine"

        def create_initializer
          create_file "config/initializers/quarterdeck.rb", <<~INITIALIZER
            # Quarterdeck configuration
            # See https://github.com/jbwl/quarterdeck for documentation
            #
            # Quarterdeck is self-contained: it renders its own CSS Zero layout and
            # assets, and only needs your app to be tracking with ahoy_matey.

            # Set up authentication (optional)
            # Quarterdeck::CssZero.authenticate_with do
            #   redirect_to main_app.root_path unless current_user&.admin?
            # end
          INITIALIZER
        end

        def mount_engine
          route 'mount Quarterdeck::CssZero::Engine => "/analytics"'
        end

        def show_post_install
          say ""
          say "Quarterdeck has been installed!", :green
          say ""
          say "  Dashboard: /analytics"
          say "  Config:    config/initializers/quarterdeck.rb"
          say ""
          say "No layout or asset changes are required: Quarterdeck renders its own"
          say "CSS Zero layout and JavaScript. Your app only needs ahoy_matey."
          say ""
        end
      end
    end
  end
end
