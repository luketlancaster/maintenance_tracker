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

  describe ".save" do
    describe "if the model is valid" do
      let(:car) { Car.new }
      it "should return true" do
        car.make = "Volkswagon"
        car.model = "Jetta"
        car.year = 2000
        assert car.save
      end
      it "should save the model to the db" do
        car.make = "Volkswagon"
        car.model = "Jetta"
        car.year = 2000
        car.save
        last_row = Database.execute("SELECT * FROM cars")[0]
        car_model = last_row['model']
        assert_equal "Jetta", car_model
      end
      it "should populate the model with the id from the db" do
        car.make = "Volkswagon"
        car.model = "Jetta"
        car.year = 2000
        car.save
        last_row = Database.execute("SELECT * FROM cars")[0]
        database_id = last_row['id']
        assert_equal database_id, car.id
      end
    end


    describe "if the model is invalid" do
      let(:car) { Car.new }
      it "should return false" do
        car.make = "Volkswagon"
        car.model = "  "
        car.year = 2000
        refute car.save
      end
      it "should not save the model to the database" do
        car.make = "Volkswagon"
        car.model = "  "
        car.year = 2000
        car.save
        assert_equal 0, Car.count
      end
      it "should populate the error message" do
        car.make = "Volkswagon"
        car.model = "  "
        car.year = 2000
        car.save
        assert_equal "\"#{car.model}\" is not a valid model", car.errors
      end
    end

    describe "if the id is already taken" do
      let(:car) { Car.new }
      it "updates the new info, but does not create a new item" do
        car.make = "VW"
        car.model = "Jetta"
        car.year = 2000
        car.save
        model_from_db = Car.all[0].model
        car_id = Car.all[0].id
        assert_equal "Jetta", model_from_db
        car.model = "Jortta"
        car.save
        model_from_db = Car.all[0].model
        should_be_same_id = Car.all[0].id
        assert_equal "Jortta", model_from_db
        assert_equal car_id, should_be_same_id
      end
    end
  end

  describe ".valid?" do
    describe "with valid data" do
      let(:car) { Car.new }
      it "returns true" do
        car.make = "Volkswagon"
        car.model = "Jetta"
        car.year = 2000
        assert_equal true, car.valid?
      end
      it "should set errors to nil?" do
        car.make = "Volkswagon"
        car.model = "Jetta"
        car.year = 2000
        car.valid?
        assert car.errors.nil?
      end
    end

    describe "with no make" do
      let(:car) { Car.new(year: 2000, make: "", model: "Jetta") }
      it "retruns false" do
        car.make = ""
        car.model = "Jetta"
        car.year = 2000
        refute car.valid?
      end
      it "sets the error message" do
        car.make = ""
        car.model = "Jetta"
        car.year = 2000
        car.valid?
        assert_equal "\"\" is not a valid make", car.errors
      end
    end

    describe "year with no numbers" do
      let(:car) { Car.new }
      it "returns false" do
        car.make = "Volkswagon"
        car.model = "Jetta"
        car.year = "Joe"
        refute car.valid?
      end
      it "sets the error message" do
        car.make = "Volkswagon"
        car.model = "Jetta"
        car.year = "Joe"
        car.valid?
        assert_equal "\"#{car.year}\" is not a valid year", car.errors
      end
    end
  end
end
