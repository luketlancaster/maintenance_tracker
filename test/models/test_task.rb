require_relative '../test_helper'

describe Task do

  describe '#all()' do
    describe 'when a proper car id is passed in' do
      before do
        create_car(2000, "VW", "Jetta")
      end
      car_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
      it 'returns all the tasks in the db for that car' do
        create_task(car_id, "Oil Change", 10000)
        actual = Task.all(car_id).map { |task| task.mileage }
        expected = [10000]
        assert_equal expected, actual
      end

      it 'returns those sorted by miles ascending' do
        create_task(car_id, "Oil Change", 10000)
        create_task(car_id, "Tire Rotation", 9800)
        actual = Task.all(car_id).map { |task| task.mileage }
        expected = [9800, 10000]
        assert_equal expected, actual
      end
    end

    describe 'if there are no tasks' do
      before do
        create_car(2000, "VW", "Jetta")
      end
      car_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
      it 'returns and empty array' do
        assert_equal [], Task.all(car_id)
      end
    end
  end

  describe '#count' do
    describe 'if thereare no tasks in the database' do
      it 'returns 0' do
        assert_equal 0, Task.count
      end
    end
    describe 'if there are tasks in the database' do
      before do
        create_car(2000, "VW", "Jetta")
        car_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
        create_task(car_id, "Oil Change", 20000)
        create_task(car_id, "Tire Rotation", 23000)
        create_task(car_id, "Fuel Filter", 24000)
      end
      it 'returns the correct amount' do
        assert_equal 3, Task.count
      end
    end
  end

  describe '.save' do
    describe 'if the task is valid' do
      before do
        create_car(2000, "VW", "Jetta")
      end
      car_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
      let (:task) { Task.new }
      it 'returns true' do
        task.mileage = 100000
        task.name = "Oil Change"
        task.instance_variable_set(:@car_id, car_id)
        assert task.save
      end
      it 'saves the mileage to the database' do
        task.mileage = 100000
        task.name = "Oil Change"
        task.instance_variable_set(:@car_id, car_id)
        task.save
        last_row = Database.execute("SELECT * FROM tasks")[0]
        name_from_db = last_row["name"]
        assert_equal task.name, name_from_db
      end
      it 'populates the task object with the task id' do
        task.mileage = 100000
        task.name = "Oil Change"
        task.instance_variable_set(:@car_id, car_id)
        task.save
        last_row = Database.execute("SELECT * FROM tasks")[0]
        id_from_db = last_row["id"]
        assert_equal task.id, id_from_db
      end
    end
    describe 'if the task is invalid' do
      before do
        create_car(2000, "VW", "Jetta")
      end
      car_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
      let (:task) { Task.new }
      it 'returns false' do
        task.mileage = "Joe"
        task.name = "Oil Change"
        task.instance_variable_set(:@car_id, car_id)
        refute task.save
      end
      it 'does not save to the database' do
        task.mileage = 0
        task.name = "Oil Change"
        task.instance_variable_set(:@car_id, car_id)
        task.save
        assert_equal 0, Task.count
      end
      it 'populates the error message' do
        task.mileage = 100000
        task.name = ""
        task.instance_variable_set(:@car_id, car_id)
        task.save
        assert_equal "\"#{task.name}\" is not a valid task name", task.errors
      end
    end
  end
end
