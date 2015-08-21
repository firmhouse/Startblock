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
end

