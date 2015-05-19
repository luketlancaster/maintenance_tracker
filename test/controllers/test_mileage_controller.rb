require_relative '../test_helper'

describe MileagesController do

  describe ".index()" do
    let(:mileages_controller) {MileagesController.new}

    it "returns a message when no mileages found" do
      create_car(2000, "Hunko", "Junko")
      car_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
      actual_output = mileages_controller.index(car_id)
      expected_output = "No mileages found. Add a record.\n"
      assert_equal expected_output, actual_output
    end

    it "returns an ordered list of miles when database populated" do
      create_car(2000, "Hunko", "Junko")
      car_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
      create_mileage(car_id, 100)
      create_mileage(car_id, 120)
      actual_output = mileages_controller.index(car_id)
      expected_output = "1. 100\n2. 120\n"
      assert_equal expected_output, actual_output
    end
  end
  describe "#add" do
    let(:mileages_controller) {MileagesController.new}
    it "adds a new mileage" do
      create_car(2000, "Hunko", "Junko")
      car_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
      mileages_controller.add(car_id, 200000)
      assert_equal 1, Mileage.count
    end

    it "adds that mileage id to the car table as well" do
      create_car(2000, "Hunko", "Junko")
      car_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
      mileages_controller.add(car_id, 20000)
      mileage_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
      car_current_mileage_id = Database.execute("SELECT current_mileage_id FROM cars WHERE id = ?", car_id)
      assert_equal car_current_mileage_id[0][0], mileage_id
    end

    it "does not add mileages that are strings" do
      create_car(2000, "Hunko", "Junko")
      car_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
      mileages_controller.add(car_id, "Josie")
      assert_equal 0, Mileage.count
    end

    it "does not add mileages that are 0" do
      create_car(2000, "Hunko", "Junko")
      car_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
      mileages_controller.add(car_id, 0)
      assert_equal 0, Mileage.count
    end

    it "does not add mileages that are whitespace" do
      create_car(2000, "Hunko", "Junko")
      car_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
      mileages_controller.add(car_id, "  ")
      assert_equal 0, Mileage.count
    end

  end
end
