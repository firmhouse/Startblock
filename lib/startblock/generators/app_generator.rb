require 'rails/generators'
require 'rails/generators/rails/app/app_generator'

module Startblock
  class AppGenerator < Rails::Generators::AppGenerator
    class_option :database, type: :string, aliases: "-d", default: "postgresql",
      desc: "Configure for selected database (options: #{DATABASES.join("/")})"

    class_option :skip_test_unit, type: :boolean, aliases: "-T", default: false,
      desc: "Skip Test::Unit files"

    class_option :skip_turbolinks, type: :boolean, default: false,
      desc: "Skip turbolinks gem"

    def finish_template
      invoke :startblock_customization
      super
    end

    def startblock_customization
      invoke :customize_gemfile
      invoke :setup_development_environment
      invoke :setup_testing_environment
      invoke :setup_staging_environment
      invoke :setup_secret_token
      invoke :create_startblock_views
      invoke :configure_app
      invoke :setup_stylesheets
      invoke :install_bitters
      invoke :install_refills
      invoke :remove_routes_comment_lines
      invoke :setup_git
      invoke :setup_database
      invoke :setup_mixpanel
      invoke :outro
    end

    def customize_gemfile
      build :replace_gemfile
      build :set_ruby_to_version_being_used

      bundle_command 'install'
    end

    def setup_development_environment
      say 'Setting up the development environment'
      build :raise_on_delivery_errors
      build :raise_on_unpermitted_parameters
      build :provide_setup_script
      build :configure_i18n_for_missing_translations
    end

    def setup_testing_environment
      say "Setting up the testing environment"
      build :configuring_test_helper
    end

    def setup_staging_environment
      say 'Setting up the staging environment'
      build :setup_staging_environment
    end

    def setup_secret_token
      say 'Moving secret token out of version control'
      build :setup_secret_token
    end

    def create_startblock_views
      say 'Creating Startblock views'
      build :create_partials_directory
      build :create_shared_flashes
      build :create_shared_javascripts
      build :create_application_layout
    end

    def configure_app
      say 'Configuring app'
      build :configure_action_mailer
      build :setup_foreman
    end

    def setup_stylesheets
      say 'Set up stylesheets'
      build :setup_stylesheets
    end

    def install_bitters
      say 'Install Bitters'
      build :install_bitters
    end

    def install_refills
      say "Install Refills"
      build :install_refills
    end

    def remove_routes_comment_lines
      build :remove_routes_comment_lines
    end

    def setup_git
      say 'Initializing git'
      build :gitignore_files
      build :init_git
    end

    def setup_database
      say 'Setting up database'

      if 'postgresql' == options[:database]
        build :use_postgres_config_template
      end

      build :create_database
    end

    def setup_mixpanel
      say 'Setting up Mixpanel'
      build :setup_mixpanel
    end

    def outro
      say 'Congratulations! You just entered our startblock.'
    end

    def run_bundle
      # Let's not: We'll bundle manually at the right spot
    end

    protected

    def get_builder_class
      Startblock::AppBuilder
    end
  end
end
