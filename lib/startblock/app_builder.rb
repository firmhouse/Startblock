module Startblock
  class AppBuilder < Rails::AppBuilder
    include Startblock::Actions

    def readme
      template 'README.md.erb', 'README.md'
    end

    def replace_gemfile
      remove_file 'Gemfile'
      template 'Gemfile.erb', 'Gemfile'
    end

    def set_ruby_to_version_being_used
      create_file '.ruby-version', "#{Startblock::RUBY_VERSION}\n"
    end

    def use_postgres_config_template
      template 'postgresql_database.yml.erb', 'config/database.yml',
        force: true
    end

    def create_database
      bundle_command 'exec rake db:create db:migrate'
    end

    def raise_on_delivery_errors
      replace_in_file 'config/environments/development.rb',
        'raise_delivery_errors = false', 'raise_delivery_errors = true'
    end

    def raise_on_unpermitted_parameters
      config = <<-RUBY
    config.action_controller.action_on_unpermitted_parameters = :raise
      RUBY

      inject_into_class "config/application.rb", "Application", config
    end

    def provide_setup_script
      remove_file "bin/setup"
      template "bin_setup.erb", "bin/setup"
      run "chmod a+x bin/setup"
    end

    def configure_i18n_for_missing_translations
      raise_on_missing_translations_in("development")
      raise_on_missing_translations_in("test")
    end

    def configuring_test_helper
      remove_file "test/test_helper.rb"
      template "test_helper.erb", "test/test_helper.rb"
    end

    def setup_staging_environment
      staging_file = 'config/environments/staging.rb'
      copy_file 'staging.rb', staging_file

      config = <<-RUBY

Rails.application.configure do
  # ...
end
      RUBY

      append_file staging_file, config
    end

    def setup_secret_token
      template 'secrets.yml', 'config/secrets.yml', force: true
    end

    def create_partials_directory
      empty_directory 'app/views/application'
    end

    def create_shared_flashes
      copy_file '_flashes.html.erb', 'app/views/application/_flashes.html.erb'
    end

    def create_shared_javascripts
      copy_file '_javascript.html.erb', 'app/views/application/_javascript.html.erb'
    end

    def create_application_layout
      template 'startblock_layout.html.erb.erb',
        'app/views/layouts/application.html.erb',
        force: true
    end

    def configure_action_mailer
      config = "config.action_mailer.delivery_method = :letter_opener"
      configure_environment("development", config)
      action_mailer_host "test", %{"www.example.com"}
    end

    def setup_foreman
      copy_file 'sample.env', '.sample.env'
      copy_file 'Procfile', 'Procfile'
    end

    def setup_stylesheets
      remove_file 'app/assets/stylesheets/application.css'
      copy_file 'application.scss',
        'app/assets/stylesheets/application.scss'
    end

    def setup_javascripts
      remove_file "app/assets/javascripts/application.js"
      copy_file "application.js", "app/assets/javascripts/application.js"
    end

    def remove_routes_comment_lines
      replace_in_file 'config/routes.rb',
        /Rails\.application\.routes\.draw do.*end/m,
        "Rails.application.routes.draw do\nend"
    end

    def gitignore_files
      remove_file '.gitignore'
      copy_file 'startblock_gitignore', '.gitignore'
    end

    def init_git
      run 'git init'
    end

    def setup_mixpanel
      copy_file '_mixpanel.html.erb',
        'app/views/application/_mixpanel.html.erb'
    end

    def setup_rubocop
      copy_file "rubocop.yml", ".rubocop.yml"
    end

    private

    def raise_on_missing_translations_in(environment)
      config = 'config.action_view.raise_on_missing_translations = true'

      uncomment_lines("config/environments/#{environment}.rb", config)
    end
  end
end
