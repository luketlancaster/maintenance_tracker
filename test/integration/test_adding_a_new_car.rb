require_relative '../test_helper.rb'

## Adding a new car

#In order to track all the vehicles under my purview I want to be able to add new cars to my database

#Usage Example:

#```
  #> ./maintenance_tracker new car
  #Please enter the year of car
  #> 2014
  #Please enter the make of car
  #> Honda
  #Please enter the model of car
  #> CRV
  #2014 Honda CRV added to database
#```

#Acceptance Criteria

#* User passes in `new` command with one argument: car
#* Three prompts are printed, asking for year, make, and model of car
#* Confirmation is printed showing user's input
#* Car is stored in database

class AddingANewCarTest < Minitest::Test

  def test_min_required_args
    shell_output = ""
    expected = ""
    IO.popen('./maintenance_tracker') do |pipe|
      expected = "(Help) Run as: ./maintenance_tracker new car\n"
      shell_output = pipe.read
    end

    assert_equal expected, shell_output
  end

  def test_manage_argument_not_given
    shell_output = ""
    expected = ""
    IO.popen('./maintenance_tracker') do |pipe|
      expected = "(Help) Run as: ./maintenance_tracker new car\n"
      shell_output = pipe.read
    end

    assert_equal expected, shell_output
  end

  def test_manage_new_command_given
    shell_output = ""
    expected = ""
    IO.popen('./maintenance_tracker new') do |pipe|
      expected = "(Help) Please supply argument 'car' or 'maintenance' after 'new' command\n"
      shell_output = pipe.read
    end

    assert_equal expected, shell_output
  end

  def test_manage_new_command_and_car_argument_given
    shell_output = ""
    expected = ""
    IO.popen('./maintenance_tracker new car', 'r+') do |pipe|
      expected << "Please enter the year of your car\n"
      pipe.puts "2000"
      expected << "Please enter the make of your car\n"
      pipe.puts "Volkswagon"
      expected << "Please enter the model of your car\n"
      pipe.puts "Jetta"
      expected << "2000 Volkswagon Jetta added to database\n"
      pipe.close_write
      shell_output = pipe.read
    end

    assert_equal expected, shell_output
  end

end
