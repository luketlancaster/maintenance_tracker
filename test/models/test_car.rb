require_relative '../test_helper'

describe Car do

  describe "#all" do
    describe "if there are no cars in the DB" do
      it "should return an empty array" do
        assert_equal [], Car.all
      end
    end
    describe "if there are cars" do
      before do
        create_car("Volkswagon", "Jetta", 2000)
        create_car("Honda", "Shadow", 1999)
        create_car("Ford", "F-150", 2012)
      end
      it "should return the models" do
        expected = ["Jetta", "Shadow", "F-150"]
        actual = Car.all.map { |car| car.model }
        assert_equal expected, actual
      end
    end
  end

  describe "#count" do
    describe "if there are no cars in the database" do
      it "should return 0" do
        assert_equal 0, Car.count
      end
    end
    describe "if there are cars" do
      before do
        create_car("VW", "Jetta", 2009)
        create_car("Chevy", "Corvette", 1987)
      end
      it "should return the correct count" do
        assert_equal 2, Car.count
      end
    end
  end

  describe "#create" do
    describe "if we need to add cars" do
      it "should add a car" do
        Car.create("VW", "Jetta", 2000)
        assert_equal 1, Car.count
      end

      it "should reject empty strings" do
        assert_raises ArgumentError do
          Car.create("", "", 0)
        end
      end
    end
  end
end
