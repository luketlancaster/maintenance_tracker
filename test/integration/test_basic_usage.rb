require_relative '../test_helper'

class TestBasicUsage < Minitest::Test

  def test_arg_not_given
    shell_output = ""
    expected = ""
    IO.popen('./maintenance_tracker') do |pipe|
      expected = "(Help) run as: './mainteance_tracker' with args: new, add, etc.\n"
      shell_output = pipe.read
    end
    assert_equal expected, shell_output
  end

end
