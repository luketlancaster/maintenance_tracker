require 'highline/import'

class TasksController

  def index(car_id)
    if Task.count > 0
      tasks = Task.all(car_id)
      tasks_string = ""
      tasks.each_with_index do |task, index|
        tasks_string << "#{index + 1}. #{task.name} at #{task.mileage} miles\n"
      end
      tasks_string
    else
      "No tasks found, add a task\n"
    end
  end

  def add(car_id, name, mileage)
    tasks = Task.new
    tasks.name = name
    tasks.mileage = mileage
    tasks.instance_variable_set(:@car_id, car_id)
    if tasks.save
      car = Database.execute("SELECT * FROM cars WHERE id == ?", car_id)
      model = car[0]['model']
      year = car[0]['year']
      make = car[0]['make']
      "#{name} for your #{year} #{make} #{model} scheduled at #{mileage} miles"
    else
      "#{tasks.errors}"
    end
  end

  def new_task
    cars = Car.all
    cars_controller = CarsController.new
    say("For which car?")
    say(cars_controller.index)
    car_index = ask('').to_i
    while car_index < 1 or car_index > cars.length
      say("#{car_index} is not a valid choice")
      say("For which car?")
      say(cars_controller.index)
      car_index = ask('')
    end
    name = ask("What is the name of the task?")
    while name.empty?
      say("#{name} is not valid input")
      name = ask("What is the name of the task?")
    end
    mileage = ask("At what miles does your #{name} need to be done?").to_i
    while mileage.nil? or mileage < 0
      say("#{mileage} is not valid input")
      mileage = ask("At what miles does your #{name} need to be done?").to_i
    end
    car_index -= 1
    car_id = cars[car_index].id
    response = self.add(car_id, name, mileage)
    say(response) unless response.nil?
  end
end
