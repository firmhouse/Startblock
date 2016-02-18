ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "capybara/rails"
require "active_support/testing/setup_and_teardown"
require "sidekiq/testing"
require 'minitest/mock'
require "mocha/mini_test"
require "minitest/rails/capybara"
require "minitest/reporters"
require "database_cleaner"
require 'capybara/poltergeist'

Sidekiq::Testing.fake!

reporter_options = { color: true, slow_count: 5 }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

DatabaseCleaner.strategy = :transaction

# Requires supporting ruby files with custom matchers and macros, etc,
# in test/support/ and its subdirectories.
Dir[Rails.root.join("test/support/**/*.rb")].each { |f| require f }

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def self.check_for_valid_fixtures(name)
    Object.const_get(name.to_s.camelize).all.each do |obj|
      raise "Fixtures for #{name} should be valid - #{obj.errors.messages}" unless obj.valid?
    end
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  use_transactional_fixtures = false


  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, js_errors: true)
  end
  Capybara.javascript_driver = :poltergeist

  setup do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  teardown do
    Capybara.reset_sessions!
    Capybara.use_default_driver
    DatabaseCleaner.clean
  end

  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_all_ajax_requests?
    end
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end

  def use_javascript
    Capybara.current_driver = Capybara.javascript_driver
  end
end
