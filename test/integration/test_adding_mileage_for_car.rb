require_relative '../test_helper.rb'

class AddingMileageForACarTest < Minitest::Test

  def test_add_mileage_for_car
    shell_output = ""
    expected_output = main_menu
    create_car(2000, "VW", "Jetta")
    create_car(1987, "Hunko", "Junko")
    IO.popen('./maintenance_tracker', 'r+') do |pipe|
      pipe.puts "4"
      expected_output << "For which car?\n"
      expected_output << "1. 2000 VW Jetta\n"
      expected_output << "2. 1987 Hunko Junko\n"
      pipe.puts "1"
      expected_output << "What is your current mileage?\n"
      pipe.puts "200000"
      expected_output << "\n\n2000 VW Jetta mileage updated to 200000 miles\n\n"
      expected_output << main_menu
      pipe.puts "11"
      shell_output = pipe.read
      pipe.close_read
      pipe.close_write
    end
    assert_equal expected_output, shell_output
  end

  def test_add_mileage_for_car_sad_path
    shell_output = ""
    expected_output = main_menu
    create_car(2000, "VW", "Jetta")
    create_car(1987, "Hunko", "Junko")
    IO.popen('./maintenance_tracker', 'r+') do |pipe|
      pipe.puts "4"
      expected_output << "For which car?\n"
      expected_output << "1. 2000 VW Jetta\n"
      expected_output << "2. 1987 Hunko Junko\n"
      pipe.puts "1"
      expected_output << "What is your current mileage?\n"
      pipe.puts " "
      expected_output << "'' is not valid input\n"
      expected_output << "What is your current mileage?\n"
      pipe.puts "200000"
      expected_output << "\n\n2000 VW Jetta mileage updated to 200000 miles\n\n"
      expected_output << main_menu
      pipe.puts "11"
      shell_output = pipe.read
      pipe.close_read
      pipe.close_write
    end
    assert_equal expected_output, shell_output
  end

end
