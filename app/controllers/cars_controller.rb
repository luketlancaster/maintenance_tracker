require 'highline/import'

class CarsController
  def index
    if Car.count > 0
      cars = Car.all
      cars_string = ""
      cars.each_with_index do |car, index|
        cars_string << "#{index + 1}. #{car.year} #{car.model}\n"
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
      "#{year} #{make} #{model} added to database"
    else
      "#{car.errors}"
    end
  end

  def prompt
    year = ''
    make = ''
    model = ''
    while year.empty? or !year.class == Fixnum
      year = ask("Please enter the year of your car")
    end
    while make.strip.empty?
      make = ask("Please enter the make of your car")
    end
    while model.strip.empty?
      model = ask("Please enter the model of your car")
    end
    response = self.add(year.to_i, make, model)
    say(response) unless response.nil?
  end

end
