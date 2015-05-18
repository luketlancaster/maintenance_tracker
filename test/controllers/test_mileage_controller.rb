require_relative '../test_helper'

describe MileagesController do
  describe "#add" do
    let(:mileages_controller) {MileagesController.new}
    it "adds a new mileage" do
      create_car(2000, "Hunko", "Junko")
      car_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
      mileages_controller.add(car_id, 200000)
      assert_equal 1, Mileage.count
    end

    it "adds that milage id to the car table as well" do
      mileage_controller = MileagesController.new
      create_car(2000, "Hunko", "Junko")
      car_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
      mileage_controller.add(car_id, 20000)
      mileage_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
      car_current_mileage_id = Database.execute("SELECT current_mileage_id FROM cars WHERE id = ?", car_id)
      assert_equal car_current_mileage_id[0][0], mileage_id
    end
  end
end
