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
      expected_output = "1. 2000 Jetta\n2. 1987 Chief\n"
      assert_equal expected_output, actual_output
    end
  end
end
