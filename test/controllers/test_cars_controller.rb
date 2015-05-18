require_relative '../test_helper'

describe CarsController do

  describe ".index" do
    let(:controller) {CarsController.new}

    it "should say no cars found when empty" do
      actual_output = controller.index
      expected_output = "No cars found. Add a car.\n"
      assert_equal expected_output, actual_output
    end

    it "should return ordered list of year and model when database populated" do
      create_car(2000, "VW", "Jetta")
      create_car(1987, "Big", "Chief")
      actual_output = controller.index
      expected_output = "1. 2000 VW Jetta\n2. 1987 Big Chief\n"
      assert_equal expected_output, actual_output
    end
  end

  describe "#add" do
    let(:controller) {CarsController.new}

    it "should add a new car" do
      controller.add(2000, "VW", "Jetta")
      assert_equal 1, Car.count
    end

    it "should only add cars with valid data" do
      controller.add("hoe", "Jimmy", "John")
      assert_equal 0, Car.count
    end

    it "should not add cars where any arguments are whitespace" do
      controller.add(1928, "   ", "")
      assert_equal 0, Car.count
    end
  end
end
