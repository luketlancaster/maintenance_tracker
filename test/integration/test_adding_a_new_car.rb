require_relative '../test_helper.rb'

class AddingANewCarTest < Minitest::Test

  def test_adding_a_car_happy_path
    shell_output = ""
    expected_output = main_menu
    IO.popen('./maintenance_tracker', 'r+') do |pipe|
      pipe.puts "4"
      expected_output << "Please enter the year of your car\n"
      pipe.puts "2000"
      expected_output << "Please enter the make of your car\n"
      pipe.puts "Volkswagon"
      expected_output << "Please enter the model of your car\n"
      pipe.puts "Jetta"
      expected_output << "\n\n2000 Volkswagon Jetta added to database\n\n"
      expected_output << main_menu
      pipe.puts "10"
      shell_output = pipe.read
      pipe.close_read
      pipe.close_write
    end

    assert_equal expected_output, shell_output
  end

  def test_manage_new_command_and_car_argument_given_sad_path
    shell_output = ""
    expected_output = main_menu
    IO.popen('./maintenance_tracker', 'r+') do |pipe|
      pipe.puts "4"
      expected_output << "Please enter the year of your car\n"
      pipe.puts "2000"
      expected_output << "Please enter the make of your car\n"
      pipe.puts ""
      expected_output << "'' is not acceptable input\n"
      expected_output << "Please enter the make of your car\n"
      pipe.puts "Volkswagon"
      expected_output << "Please enter the model of your car\n"
      pipe.puts "Jetta"
      expected_output << "\n\n2000 Volkswagon Jetta added to database\n\n"
      expected_output << main_menu
      pipe.puts "10"
      shell_output = pipe.read
      pipe.close_read
      pipe.close_write
    end

    assert_equal expected_output, shell_output
  end

end
