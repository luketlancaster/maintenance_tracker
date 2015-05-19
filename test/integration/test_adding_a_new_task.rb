require_relative '../test_helper.rb'

### Adding maintenance

#In order to keep on top of upcoming maintenance I want to be able to add events based on mileage

#Usage Example:

#```
  #> ./maintenance_tracker add
  #For which car?
  #1. 2000 Jetta
  #2. 2012 CRV
  #3. 2014 Silverado
  #> 1
  #What job?
  #> Oil Change
  #At what mileage?
  #> 2000000
  #Oil Change for your 2000 Jetta Scheduled at 200000 miles
#```

#Acceptance Criteria

#* User passes in `add` command
#* Program asks for which car, displaying a menu
#* The program asks three questions: "What Job?" and
  #"At what mileage?"
#* The user inputs the appropriate answers
#* That new maintenance is printed out with the mileage it is schudled at


class AddingANewTaskTest < Minitest::Test

  def test_add_new_task
    shell_output = ""
    expected_output = ""
    create_car(2000, "VW", "Jetta")
    create_car(1987, "Hunko", "Junko")
    create_car(2390, "Futuro", "Zipper")
    IO.popen('./maintenance_tracker add', 'r+') do |pipe|
      expected_output << "For which car?\n"
      expected_output << "1. 2000 VW Jetta\n"
      expected_output << "2. 1987 Hunko Junko\n"
      expected_output << "3. 2390 Futuro Zipper\n"
      pipe.puts "2"
      expected_output << "What task would you like to add?\n"
      pipe.puts "Oil Change"
      expected_output << "At what mileage?\n"
      pipe.puts "20000000"
      expected_output << "Oil Changed for your 1987 Hunko Junko scheduled at 20000000 miles\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

end
