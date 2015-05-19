require_relative '../test_helper.rb'

class AddingANewTaskTest < Minitest::Test

  def test_add_new_task
    shell_output = ""
    expected_output = main_menu
    create_car(2000, "VW", "Jetta")
    create_car(1987, "Hunko", "Junko")
    IO.popen('./maintenance_tracker', 'r+') do |pipe|
      pipe.puts "6"
      expected_output << "For which car?\n"
      expected_output << "1. 2000 VW Jetta\n2. 1987 Hunko Junko\n"
      pipe.puts "2"
      expected_output << "What is the name of the task?\n"
      pipe.puts "Oil Change"
      expected_output << "At what miles does your Oil Change need to be done?\n"
      pipe.puts "2000"
      expected_output << "Oil Change for your 1987 Hunko Junko scheduled at 2000 miles\n"
      expected_output << main_menu
      pipe.puts "10"
      shell_output = pipe.read
      pipe.close_read
      pipe.close_write
    end
    assert_equal expected_output, shell_output
  end

  def test_add_new_task_sad_path
    shell_output = ""
    expected_output = main_menu
    create_car(2000, "VW", "Jetta")
    create_car(1987, "Hunko", "Junko")
    IO.popen('./maintenance_tracker', 'r+') do |pipe|
      pipe.puts "6"
      expected_output << "For which car?\n"
      expected_output << "1. 2000 VW Jetta\n2. 1987 Hunko Junko\n"
      pipe.puts "2"
      expected_output << "What is the name of the task?\n"
      pipe.puts "Oil Change"
      expected_output << "At what miles does your Oil Change need to be done?\n"
      pipe.puts "  "
      expected_output << "'' is not valid input\n"
      expected_output << "At what miles does your Oil Change need to be done?\n"
      pipe.puts "2000"
      expected_output << "Oil Change for your 1987 Hunko Junko scheduled at 2000 miles\n"
      expected_output << main_menu
      pipe.puts "10"
      shell_output = pipe.read
      pipe.close_read
      pipe.close_write
    end
    assert_equal expected_output, shell_output

  end

end
