require_relative '../test_helper'

class DeletingACarTest < Minitest::Test

  def test_deleting_a_car_happy_path
    shell_output = ""
    expected_output = main_menu
    create_car(2000, "VW", "Jetta")
    create_car(2009, "Heaping", "Pile")
    car_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
    create_task(car_id, "Oil Change", 10000)
    create_task(car_id, "Drive", 120988)
    IO.popen('./maintenance_tracker', 'r+') do |pipe|
      pipe.puts "9"
      expected_output << "Which car would you like to delete?\n"
      expected_output << "1. 2000 VW Jetta\n2. 2009 Heaping Pile\n"
      pipe.puts "2"
      expected_output << "To confirm, please enter year, make, and model of this car\n"
      pipe.puts "2009 Heaping Pile"
      expected_output << "\n\n2009 Heaping Pile and all maintenance records removed\n\n"
      expected_output << main_menu
      pipe.puts "11"
      shell_output = pipe.read
      pipe.close_read
      pipe.close_write
    end
    assert_equal expected_output, shell_output
  end

  def test_deleting_a_car_sad_path
    shell_output = ""
    expected_output = main_menu
    create_car(2000, "VW", "Jetta")
    create_car(2009, "Heaping", "Pile")
    car_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
    create_task(car_id, "Oil Change", 10000)
    create_task(car_id, "Drive", 120988)
    IO.popen('./maintenance_tracker', 'r+') do |pipe|
      pipe.puts "9"
      expected_output << "Which car would you like to delete?\n"
      expected_output << "1. 2000 VW Jetta\n2. 2009 Heaping Pile\n"
      pipe.puts "2"
      expected_output << "To confirm, please enter year, make, and model of this car\n"
      pipe.puts "2009 Heaping Pole"
      expected_output << "Incorrect input, please try again\n"
      expected_output << main_menu
      pipe.puts "11"
      shell_output = pipe.read
      pipe.close_read
      pipe.close_write
    end
    assert_equal expected_output, shell_output
  end

end
