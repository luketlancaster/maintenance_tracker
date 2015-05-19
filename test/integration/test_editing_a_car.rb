require_relative '../test_helper'

class EditingACarTest < Minitest::Test

  def test_happy_path_edit_car_make
    shell_output = ""
    expected_output = ""
    create_car(2000, "VW", "Jetta")
    create_car(1987, "Big", "Chief")
    IO.popen('./maintenance_tracker edit car', 'r+') do |pipe|
      expected_output << "Which car would you like to edit?\n"
      expected_output << "1. 2000 VW Jetta\n"
      expected_output << "2. 1987 Big Chief\n"
      pipe.puts "2"
      expected_output << "What would you like to edit: make, model, or year?\n"
      pipe.puts "make\n"
      expected_output << "Please enter the updated make\n"
      pipe.puts "Bigger\n"
      expected_output << "1987 Big Chief has been updated to 1987 Bigger Chief\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_sad_path_editing_a_car
    shell_output = ""
    expected_output = ""
    create_car(2000, "VW", "Jetta")
    create_car(1987, "Big", "Chief")
    IO.popen('./maintenance_tracker edit car', 'r+') do |pipe|
      expected_output << "Which car would you like to edit?\n"
      expected_output << "1. 2000 VW Jetta\n"
      expected_output << "2. 1987 Big Chief\n"
      pipe.puts "2"
      expected_output << "What would you like to edit: make, model, or year?\n"
      pipe.puts "year\n"
      expected_output << "Please enter the updated year\n"
      pipe.puts ""
      expected_output << "Please enter the updated year\n"
      pipe.puts "3000"
      expected_output << "1987 Big Chief has been updated to 3000 Big Chief\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output

  end
end
