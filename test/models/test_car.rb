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


      describe "if the model if invalid" do
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

  describe ".update" do
    describe "edit previously saved car" do
      let (:car) { Car.new }
      let (:new_car_make) { "Junker" }
      it "should update the car make, but not the id" do
        skip
        car.make = "Chrysler"
        car.model = "Sebring"
        car.year = 2006
        car.save
        assert_equal 1, Car.count
        car_to_update = Database.execute("SELECT * FROM cars WHERE make LIKE ?", car.make)[0]
        car_id = car_to_update['id']
        car.update(car.make, new_car_make)
        last_row = Database.execute("SELECT * FROM cars")[0]
        car_make_from_db = last_row['make']
        assert_equal new_car_make, car_make_from_db
      end
    end
  end
end
