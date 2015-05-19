require 'highline/import'

class MileagesController

  def index(car_id)
    if Mileage.count > 0
      miles = Mileage.all(car_id)
      miles_string = ""
      miles.each_with_index do |mile, index|
        miles_string << "#{index + 1}. #{mile.mileage}\n"
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
      "\n\n#{year} #{make} #{model} mileage updated to #{mileage} miles\n\n"
    else
      "#{miles.errors}"
    end
  end

  def update_miles
    cars = Car.all
    cars_controller = CarsController.new
    say("For which car?")
    say(cars_controller.index)
    car_index = ask('').to_i
    while car_index.to_i < 1 or car_index > cars.length
      say("#{car_index} is not a valid choice")
      say("For which car?")
      say(cars_controller.index)
      car_index = ask('')
    end
    miles = ask("What is your current mileage?")
    while miles.to_i < 1 or miles.empty? or miles.nil?
      puts "'#{miles}' is not valid input"
      miles = ask("What is your current mileage?")
    end
    car_index = car_index.to_i - 1
    car_id = cars[car_index].id
    response = self.add(car_id, miles.to_i)
    say(response) unless response.nil?
  end

end
