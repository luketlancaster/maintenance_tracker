require_relative '../test_helper'

class EditingACarTest < Minitest::Test

  def test_happy_path_edit_car_make
    shell_output = ""
    expected_output = main_menu
    create_car(2000, "VW", "Jetta")
    create_car(1987, "Big", "Chief")
    IO.popen('./maintenance_tracker', 'r+') do |pipe|
      pipe.puts "5"
      expected_output << "Which car would you like to edit?\n"
      expected_output << "1. 2000 VW Jetta\n2. 1987 Big Chief\n"
      pipe.puts "1"
      expected_output << "What would you like to edit: make, model, or year?\n"
      pipe.puts "make"
      expected_output << "Please enter the updated make\n"
      pipe.puts "Volkswagon"
      expected_output << "\n\n2000 VW Jetta has been updated to 2000 Volkswagon Jetta\n\n"
      expected_output << main_menu
      pipe.puts "10"
      shell_output = pipe.read
      pipe.close_read
      pipe.close_write
    end
    assert_equal expected_output, shell_output
  end

  def test_sad_path_editing_a_car
    shell_output = ""
    expected_output = main_menu
    create_car(2000, "VW", "Jetta")
    create_car(1987, "Big", "Chief")
    IO.popen('./maintenance_tracker', 'r+') do |pipe|
      pipe.puts "5"
      expected_output << "Which car would you like to edit?\n"
      expected_output << "1. 2000 VW Jetta\n2. 1987 Big Chief\n"
      pipe.puts "1"
      expected_output << "What would you like to edit: make, model, or year?\n"
      pipe.puts "year"
      expected_output << "Please enter the updated year\n"
      pipe.puts " "
      expected_output << "'' is not acceptable input\n"
      expected_output << "Please enter the updated year\n"
      pipe.puts "3000"
      expected_output << "\n\n2000 VW Jetta has been updated to 3000 VW Jetta\n\n"
      expected_output << main_menu
      pipe.puts "10"
      shell_output = pipe.read
      pipe.close_read
      pipe.close_write
    end
    assert_equal expected_output, shell_output
  end
end
