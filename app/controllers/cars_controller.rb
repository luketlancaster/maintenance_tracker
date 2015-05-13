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
end
