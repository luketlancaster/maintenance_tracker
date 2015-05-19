require 'highline/import'

class CarsController
  def index
    if Car.count > 0
      cars = Car.all
      cars_string = ""
      cars.each_with_index do |car, index|
        cars_string << "#{index + 1}. #{car.year} #{car.make} #{car.model}\n"
      end
      cars_string
    else
      "No cars found. Add a car.\n"
    end
  end

  def add(year, make, model)
    car = Car.new
    car.year = year
    car.make = make
    car.model = model
    if car.save
      "\n\n#{year} #{make} #{model} added to database\n\n"
    else
      "#{car.errors}"
    end
  end

  def new_car
    year = ask("Please enter the year of your car")
    while year.to_i == 0 or year.empty? or year.nil?
      puts "'#{year}' is not acceptable input"
      year = ask("Please enter the year of your car")
    end
    make = ask("Please enter the make of your car")
    while make.strip.empty?
      puts "'#{make}' is not acceptable input"
      make = ask("Please enter the make of your car")
    end
    model = ask("Please enter the model of your car")
    while model.strip.empty?
      puts "'#{model}' is not acceptable input"
      model = ask("Please enter the model of your car")
    end
    response = self.add(year.to_i, make, model)
    say(response) unless response.nil?
  end

  def edit_car
    cars = Car.all
    cars_controller = CarsController.new
    say("Which car would you like to edit?")
    say(cars_controller.index)
    car_index = ask('')
    while car_index.to_i < 1 or car_index.empty? or car_index.nil? or car_index.to_i > cars.length
      puts "'#{car_index}' is not acceptable input"
      say("Which car would you like to edit?")
      say(cars_controller.index)
      car_index = ask('')
    end
    car_index = car_index.to_i - 1
    car = cars[car_index]
    old_car = "#{car.year} #{car.make} #{car.model}"
    choice = ask("What would you like to edit: make, model, or year?")
    if choice == "make"
      car.make = ask("Please enter the updated make")
      while car.make.empty?
        puts "'#{car.make}' is not acceptable input"
        car.make = ask("Please enter the updated make")
      end
    elsif choice == "model"
      car.model = ask("Please enter the updated model")
      while car.model.empty?
        puts "'#{car.model}' is not acceptable input"
        car.model = ask("Please enter the updated model")
      end
    elsif choice == "year"
      car.year = ask("Please enter the updated year")
      while car.year.empty?
        puts "'#{car.year}' is not acceptable input"
        car.year = ask("Please enter the updated year")
      end
    end
    if car.save
      say("\n\n#{old_car} has been updated to #{car.year} #{car.make} #{car.model}\n\n")
      return
    else
      say(car.errors)
    end
  end

end
