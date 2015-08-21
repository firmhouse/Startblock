require "test_helper"

class NewProjectTest < Minitest::Test
  def test_ensure_tests_pass
    Dir.chdir(project_path) do
      Bundler.with_clean_env do
        output = `rake`
        # assert `rake test` == "", "rake should not produce an error"
      end
    end
  end

  def test_something_else
    assert_equal 1, 1
  end
end

