require_relative '../test_helper'

describe TasksController do

  describe ".index()" do
    create_car(2000, "Hunko", "Junko")
    car_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
    let(:tasks_controller) { TasksController.new }
    it "returns 'no tasks found: add a task' when empty" do
      actual_output = tasks_controller.index(car_id)
      expected_output = "No tasks found, add a task\n"
      assert_equal expected_output, actual_output
    end

    it "returns an ordered list of tasks for specified car when db populated" do
      create_task(car_id, "Oil Change", 100000)
      create_task(car_id, "Tire Rotation", 120000)
      expected_output = "1. Oil Change at 100000 miles\n2. Tire Rotation at 120000 miles\n"
      actual_output = tasks_controller.index(car_id)
      assert_equal expected_output, actual_output
    end
  end

  describe ".add()" do
    create_car(2000, "Hunko", "Junko")
    car_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
    let(:tasks_controller) { TasksController.new }
    it "adds a new task" do
      create_car(2000, "Hunko", "Junko")
      car_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
      tasks_controller.add(car_id, "Oil Change", 100000)
      assert_equal 1, Task.count
    end

    it "only adds tasks with valid names" do
      create_car(2000, "Hunko", "Junko")
      car_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
      tasks_controller.add(car_id, "   ", 100000)
      assert_equal 0, Task.count
    end

    it "only adds taks with valid mileage" do
      tasks_controller.add(car_id, "Orl Charnge", "Joseph")
      assert_equal 0, Task.count
    end

    it "does not add when arguments are whitespace" do
      tasks_controller.add(car_id, "Jorph", " ")
      assert_equal 0, Task.count
    end
  end
end
