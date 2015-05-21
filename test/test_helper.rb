ENV["TEST"] = 'true'

require 'rubygems'
require 'bundler/setup'
require 'minitest/reporters'
require_relative '../lib/environment'


reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

require 'minitest/autorun'
class Minitest::Test
  def setup
    Database.load_structure
    Database.execute("DELETE FROM cars;")
    Database.execute("DELETE FROM tasks;")
    Database.execute("DELETE FROM mileages;")
  end
end

def main_menu
  "1. List Cars\n2. List Tasks\n3. Current Mileage\n4. Update Mileage\n5. New Car\n6. Edit Car\n7. New Task\n8. Edit Task\n9. Delete Car\n10. Delete Task\n11. Exit\n"
end

def create_car(year, make, model)
  Database.execute("INSERT INTO cars (year, make, model) VALUES (?,?,?)", year, make, model)
end

def create_task(car_id, name, mileage)
  Database.execute("INSERT INTO tasks (car_id, name, mileage) VALUES (?,?,?)", car_id, name, mileage)
end

def create_mileage(car_id, mileage)
  Database.execute("INSERT INTO mileages (car_id, mileage) VALUES (?,?)", car_id, mileage)
  mileage_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
  Database.execute("UPDATE cars SET current_mileage_id = ? WHERE id = ?", mileage_id, car_id)
end
