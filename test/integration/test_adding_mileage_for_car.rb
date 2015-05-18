require_relative '../test_helper.rb'

class AddingMileageForACarTest < Minitest::Test

  def test_add_mileage_for_car
    shell_output = ""
    expected_output = ""
    create_car(2000, "VW", "Jetta")
    create_car(1987, "Hunko", "Junko")
    create_car(2390, "Futuro", "Zipper")
    IO.popen('./maintenance_tracker update miles', 'r+') do |pipe|
      expected_output << "For which car?\n"
      expected_output << "1. 2000 VW Jetta\n"
      expected_output << "2. 1987 Hunko Junko\n"
      expected_output << "3. 2390 Futuro Zipper\n"
      pipe.puts "1"
      expected_output << "What is your current mileage?\n"
      pipe.puts "200000"
      expected_output << "2000 VW Jetta mileage updated to 200000 miles\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end
end
