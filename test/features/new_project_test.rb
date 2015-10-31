require "test_helper"

class NewProjectTest < Minitest::Test
  def test_ensure_tests_pass
    Dir.chdir(project_path) do
      Bundler.with_clean_env do
        ENV["TEST"] = nil
        assert `rake test` == "", "rake should not produce an error"
      end
    end
  end

  def test_ruby_version_file
    ruby_version_file = IO.read("#{project_path}/.ruby-version")
    assert_equal ruby_version_file, "#{RUBY_VERSION}\n"
  end

  def test_rubocop_should_pass
    Dir.chdir(project_path) do
      Bundler.with_clean_env do
        assert `rubocop`.match(/no offenses detected/), "Rubocop should not be offended"
      end
    end
  end

  def test_gemfile_should_contain_certain_gems
    gemfile = IO.read("#{project_path}/Gemfile")

    assert gemfile.match(/bootstrap-sass/), "Gemfile should contain bootstrap-sass gem"
    assert gemfile.match(/quiet_assets/), "Gemfile should contain quiet assets gem"
    assert gemfile.match(/nprogress-rails/), "Gemfile should contain NProgress-rails"
  end

  def test_application_js_should_b_created
    app_js_file = IO.read("#{project_path}/app/assets/javascripts/application.js")

    assert app_js_file.match(/= require jquery.turbolinks/), "Jquery.turbolinks should be present"
    assert app_js_file.match(/= require bootstrap-sprockets/), "Bootstrap should be present"
    assert app_js_file.match(/= require nprogress/), "Nprogress should be present"
    assert app_js_file.match(/FastClick.attach/), "Fastclick should be initialized"
  end

  def test_gitignore_should_be_created
    app_ignore_file = IO.read("#{project_path}/.gitignore")

    assert app_ignore_file.match(/passenger/), "Passenger ignore should be present"
    assert app_ignore_file.match(/env/), ".env ignore should be present"
  end

  def test_application_css_should_be_created
    app_css_file = IO.read("#{project_path}/app/assets/stylesheets/application.scss")

    assert app_css_file.match(/bootstrap/), "Bootstrap should be present"
    assert app_css_file.match(/nprogress/), "Nprogress should be present"
  end

  def test_develoment_rb_content
    development_rb_file = IO.read("#{project_path}/config/environments/development.rb")

    assert development_rb_file.match(/letter_opener/), "Should have the letter opener"
  end
end

