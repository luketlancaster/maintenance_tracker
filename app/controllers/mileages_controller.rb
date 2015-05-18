require 'highline/import'

class MileagesController

  def index
    if Mileage.count > 0
      miles = Mileage.all
      miles_string = ""
      miles.each_with_index do |car, index|
        miles_string << "#{index + 1}. #{miles.mileage}\n"
      end
      miles_string
    else
      "No mileages found. Add a record.\n"
    end
  end

  def add(car_id, mileage)
    miles = Mileage.new
    miles.mileage = mileage
    miles.instance_variable_set(:@car_id, car_id)
    if miles.save
      car = Database.execute("SELECT * FROM cars WHERE id == ?", car_id)
      model = car[0]['model']
      year = car[0]['year']
      make = car[0]['make']
      "#{year} #{make} #{model} mileage updated to #{mileage} miles"
    else
      "#{miles.errors}"
    end
  end

  def update_miles
    cars_controller = CarsController.new
    say("For which car?")
    say(cars_controller.index)
    car_index = ask('')
    while car_index.to_i < 1 or car_index.empty? or car_index.nil?
      puts "'#{car_index}' is not acceptable input"
      car_index = ask("For which car?")
    end
    miles = ask("What is your current mileage?")
    while miles.to_i < 1 or miles.empty? or miles.nil?
      puts "'#{miles}' is not acceptable input"
      miles = ask("What is your current mileage?")
    end
    cars = Car.all
    car_index = car_index.to_i - 1
    car_id = cars[car_index].id
    response = self.add(car_id, miles.to_i)
    say(response) unless response.nil?
  end

end
