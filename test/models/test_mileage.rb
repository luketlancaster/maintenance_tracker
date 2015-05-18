require_relative '../test_helper'

describe Mileage do

  describe '#all()' do
    describe 'when a proper car id is passed in' do
      create_car(2000, "VW", "Jetta")
      car_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
      it 'returns all mileage readings for that car' do
        create_mileage(car_id, 100000)
        actual = Mileage.all(car_id).map { |miles| miles.mileage }
        expected = [100000]
        assert_equal expected, actual
      end

      it 'returns those milages in reverse chronological order' do
        create_mileage(car_id, 100)
        create_mileage(car_id, 120)
        create_mileage(car_id, 130)
        actual = Mileage.all(car_id).map { |miles| miles.mileage }
        expected = [100, 120, 130]
        assert_equal expected, actual
      end
    end

    describe 'when an improper car id is passed in' do
      it 'returns a message' do

      end

    end

    describe 'if there are no milage amounts' do
      create_car(2000, "VW", "Jetta")
      car_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
      it 'returns an empty array' do
        assert_equal [], Mileage.all(car_id).map { |miles| miles.mileage }
      end
    end
  end

  describe "#count" do
    describe "if there are no mileage readings in the database" do
      it "should return 0" do
        assert_equal 0, Mileage.count
      end
    end
    describe "if there are readings" do
      create_car(2000, "VW", "Jetta")
      car_id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
      before do
        create_mileage(car_id, 100)
        create_mileage(car_id, 120)
        create_mileage(car_id, 130)
      end
      it "should return the correct count" do
        assert_equal 3, Mileage.count
      end
    end
  end

  describe "#save" do
    describe "if the milage is valid" do
      it "returns true" do

      end
      it "saves the mileage to the database" do

      end
      it "populates the mileage with the id from the database"

    end

    describe "if the milage is invalid" do
      it "returns false" do

      end
      it "does not save to the database" do

      end
      it "populates the error message" do

      end
    end
  end
end
