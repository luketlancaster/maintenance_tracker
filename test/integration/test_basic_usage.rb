require_relative '../test_helper'

class TestBasicUsage < Minitest::Test

  def test_arg_not_given
    shell_output = ""
    expected_output = ""
    IO.popen('./maintenance_tracker', 'r+') do |pipe|
      expected_output << main_menu
      pipe.puts "10"
      shell_output = pipe.read
      pipe.close_read
      pipe.close_write
    end
    assert_equal expected_output, shell_output
  end

end
