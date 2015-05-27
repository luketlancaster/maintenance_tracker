require 'highline/import'
require 'date'

class MileagesController

  def index(car_id)
    if Mileage.count > 0
      miles_string = ""
      Mileage.where(car_id: car_id).each_with_index do |mile, index|
        date = mile.date.strftime('%B %d %Y')
        miles_string << "#{index + 1}. #{mile.mileage} miles on #{date}\n"
      end
      miles_string
    else
      "No mileages found. Add a record.\n"
    end
  end

  def add(car_id, mileage)
    miles = Mileage.new
    miles.mileage = mileage
    if miles.save
      car = Car.find(car_id)
      miles.update(car_id: car_id)
      "\n\n#{car.year} #{car.make} #{car.model} mileage updated to #{mileage} miles\n\n"
    else
      "#{miles.errors}"
    end
  end

  def list
    cars = Car.all
    cars_controller = CarsController.new
    say("For which car?")
    say(cars_controller.index)
    car_index = ask('').to_i
    while car_index < 1 or car_index > cars.length
      say("#{car_index} is not a valid choice")
      say("For which car?")
      say(cars_controller.index)
      car_index = ask('').to_i
    end
    car_index -= 1
    car = cars[car_index].id
    say(self.index(car))
    loop do
      continue = ask("Continue?(y/n)")
      if continue == 'y'
        break
      end
      say(self.index(car))
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
      car_index = ask('').to_i
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
