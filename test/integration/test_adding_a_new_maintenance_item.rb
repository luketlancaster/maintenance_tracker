require_relative '../test_helper.rb'

### Adding maintenance

#In order to keep on top of upcoming maintenance I want to be able to add events based on mileage

#Usage Example:

#```
  #> ./maintenance_tracker add "Tire Rotation" 180000 Jetta
  #Tire Rotation scheduled for Volkswagon Jetta at 180000 miles
#```

#Acceptance Criteria

#* User passes in `new` command followed by three arguments: Job,
  #Miles, Name of car
#* That new maintenance is printed out with the mileage it is schudled at

class AddingANewMaintenanceItemTest < Minitest::Test

  def test_arg_not_given
    shell_output = ""
    expected = ""
    IO.popen('./maintenance_tracker') do |pipe|
      expected = "(Help) Run as: ./mainteance_tracker add 'Oil Change' 19000 CRV\n"
      shell_output = pipe.read
    end
    assert_equal expected, shell_output
  end

  def test_add_command_but_no_arguments
    shell_output = ""
    expected = ""
    IO.popen('./maintenance_tracker add', 'r+') do |pipe|
      expected << "What job?\n"
      pipe.puts "Oil Change"
      expected << "For which car?\n"
      pipe.puts "CRV"
      expected << "At what mileage?\n"
      pipe.puts "20000"
      expected << "Oil Change scheduled for your CRV at 20000 miles\n"
      pipe.close_write
      shell_output = pipe.read
    end

    assert_equal expected, shell_output
  end

  def test_ignore_extra_input
    shell_output = ""
    expected = ""
    IO.popen('./maintenance_tracker add joe', 'r+') do |pipe|
      expected << "What job?\n"
      pipe.puts "Tire Rotation"
      expected << "For which car?\n"
      pipe.puts "Jetta"
      expected << "At what mileage?\n"
      pipe.puts "200000"
      expected << "Tire Rotation scheduled for your Jetta at 200000 miles\n"
      pipe.close_write
      shell_output = pipe.read
    end

    assert_equal expected, shell_output

  end
end
