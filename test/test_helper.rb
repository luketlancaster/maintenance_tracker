require 'rubygems'
require 'bundler/setup'
require "minitest/reporters"
Dir["./app/**/*.rb"].each { |f| require f }
Dir["./lib/*.rb"].each { |f| require f }
ENV["TEST"] = 'true'

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

require 'minitest/autorun'
class Minitest::Test
  def setup
    Database.load_structure
    Database.execute("DELETE FROM cars;")
    Database.execute("DELETE FROM tasks;")
  end
end

def create_car(year, make, model)
  Database.execute("INSERT INTO cars (year, make, model) VALUES (?,?,?)", year, make, model)
end

def create_task(car_id, name, mileage)
  Database.execute("INSERT INTO tasks (car_id, name, mileage) VALUES (?,?,?)", car_id, name, mileage)
end
