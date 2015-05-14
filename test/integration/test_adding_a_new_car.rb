require_relative '../test_helper.rb'

class AddingANewCarTest < Minitest::Test

  def test_manage_new_command_given
    shell_output = ""
    expected = ""
    IO.popen('./maintenance_tracker new') do |pipe|
      expected = "(Help) Please supply argument 'car' or 'job' after 'new' command\n"
      shell_output = pipe.read
    end

    assert_equal expected, shell_output
  end

  def test_manage_new_command_and_car_argument_given_happy_path
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

  def test_manage_new_command_and_car_argument_given_sad_path
    shell_output = ""
    expected = ""
    IO.popen('./maintenance_tracker new car', 'r+') do |pipe|
      expected << "Please enter the year of your car\n"
      pipe.puts "2000"
      expected << "Please enter the make of your car\n"
      pipe.puts ""
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
