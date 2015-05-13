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
        create_car(2000, "Volkswagon", "Jetta")
        create_car(1999, "Honda", "Shadow")
        create_car(2013, "Ford", "F-150")
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
        create_car(2000, "VW", "Jetta")
        create_car(1987, "Chevy", "Corvette")
      end
      it "should return the correct count" do
        assert_equal 2, Car.count
      end
    end
  end

  describe "#create" do
    describe "if we need to add cars" do
      it "should add a car" do
        Car.create(2000, "VW", "Jetta")
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
