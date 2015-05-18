require_relative '../test_helper'

class EditingACarTest < Minitest::Test

  def test_happy_path_edit_car_make
    skip
    shell_output = ""
    expected_output = ""
    create_car(2000, "VW", "Jetta")
    create_car(1987, "Big", "Chief")
    IO.popen('./mainteance_tracker edit car', '+r') do |pipe|
      expected_output << "Which car would you like to edit?\n"
      expected_output << "1. 2000 Volkswagon Jetta\n"
      expected_output << "2. 1987 Big Chief\n"
      pipe.puts "2"
      expected_output << "What would you like to edit: make, model, or year?\n"
      pipe.puts "make\n"
      expected_output << "What is the new make?\n"
      pipe.puts "Bigger\n"
      expected_output << "1987 Big Chief now 1987 Bigger Chief\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_user_left_car_unchanged

  end

  def test_sad_path_editing_a_car

  end
end
