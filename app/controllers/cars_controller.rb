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
    make_cleaned = make.strip
    model_cleaned = model.strip
    if year.is_a?(Fixnum) or make_cleaned.empty? or model_cleaned.empty?
      Car.create(year, make_cleaned, model_cleaned)
      [year, make_cleaned, model_cleaned]
    end
  end

  def prompt
    year = ask("Please enter the year of your car")
    make = ask("Please enter the make of your car")
    model = ask("Please enter the model of your car")
    self.add(year.to_i, make, model)
    say("#{year} #{make} #{model} added to database")
  end

end
