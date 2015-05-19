require_relative '../test_helper'

class EditingATaskTest < Minitest::Test

  def test_happy_path_edit_task_name
    shell_output = ""
    expected_output = main_menu
    create_car(2000, "VW", "Jetta")
    car_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
    create_task(car_id, "Oil Change", 10000)
    create_task(car_id, "Rotato Tires", 20000)
    IO.popen('./maintenance_tracker', 'r+') do |pipe|
      pipe.puts '7'
      expected_output << "For which car?\n"
      expected_output << "1. 2000 VW Jetta\n"
      pipe.puts "1"
      expected_output << "What task would you like to edit?\n"
      expected_output << "1. Oil Change at 10000 miles\n"
      expected_output << "2. Rotato Tires at 20000 miles\n"
      pipe.puts "2"
      expected_output << "What would you like to edit: name or mileage?\n"
      pipe.puts "name"
      expected_output << "Please enter the updated name\n"
      pipe.puts "Rotate Tires"
      expected_output << "\n\nRotato Tires name changed to Rotate Tires\n\n"
      expected_output << main_menu
      pipe.puts "10"
      shell_output = pipe.read
      pipe.close_read
      pipe.close_write
    end
    assert_equal expected_output, shell_output
  end

  def test_happy_path_edit_task_mileage
    shell_output = ""
    expected_output = main_menu
    create_car(2000, "VW", "Jetta")
    car_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
    create_task(car_id, "Oil Change", 10000)
    create_task(car_id, "Rotato Tires", 20000)
    IO.popen('./maintenance_tracker', 'r+') do |pipe|
      pipe.puts "7"
      expected_output << "For which car?\n"
      expected_output << "1. 2000 VW Jetta\n"
      pipe.puts "1"
      expected_output << "What task would you like to edit?\n"
      expected_output << "1. Oil Change at 10000 miles\n"
      expected_output << "2. Rotato Tires at 20000 miles\n"
      pipe.puts "2"
      expected_output << "What would you like to edit: name or mileage?\n"
      pipe.puts "mileage"
      expected_output << "Please enter the updated mileage\n"
      pipe.puts "210000"
      expected_output << "\n\nRotato Tires mileage changed from 20000 to 210000\n\n"
      expected_output << main_menu
      pipe.puts "10"
      shell_output = pipe.read
      pipe.close_read
      pipe.close_write
    end
    assert_equal expected_output, shell_output

  end

  def test_sad_path_edit_task_name
    shell_output = ""
    expected_output = main_menu
    create_car(2000, "VW", "Jetta")
    car_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
    create_task(car_id, "Oil Change", 10000)
    create_task(car_id, "Rotato Tires", 20000)
    IO.popen('./maintenance_tracker', 'r+') do |pipe|
      pipe.puts "7"
      expected_output << "For which car?\n"
      expected_output << "1. 2000 VW Jetta\n"
      pipe.puts "1"
      expected_output << "What task would you like to edit?\n"
      expected_output << "1. Oil Change at 10000 miles\n"
      expected_output << "2. Rotato Tires at 20000 miles\n"
      pipe.puts "2"
      expected_output << "What would you like to edit: name or mileage?\n"
      pipe.puts "name"
      expected_output << "Please enter the updated name\n"
      pipe.puts ""
      expected_output << "\"\" is not acceptable input\n"
      expected_output << "Please enter the updated name\n"
      pipe.puts "Rotate Tires"
      expected_output << "\n\nRotato Tires name changed to Rotate Tires\n\n"
      expected_output << main_menu
      pipe.puts "10"
      shell_output = pipe.read
      pipe.close_read
      pipe.close_write
    end
    assert_equal expected_output, shell_output
  end
end
