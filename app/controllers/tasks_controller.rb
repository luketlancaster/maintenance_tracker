require 'highline/import'

class TasksController

  def index(car_id)
    if Task.count > 0
      tasks = Task.all(car_id)
      tasks_string = ""
      tasks.each_with_index do |task, index|
        if task.completed == 0
          tasks_string << "#{index + 1}. #{task.name} at #{task.mileage} miles\n"
        else
          tasks_string << "#{index + 1}. √ #{task.name} at #{task.mileage} miles\n"
        end
      end
      tasks_string
    else
      return "No tasks found, add a task\n"
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
    say("\n\n#{self.index(car)}\n\n")
    loop do
      continue = ask("Continue?(y/n)")
      if continue == 'y'
        break
      end
      say(self.index(car))
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
      car_index = ask('').to_i
    end
    name = ask("What is the name of the task?")
    while name.empty?
      say("#{name} is not valid input")
      name = ask("What is the name of the task?")
    end
    mileage = ask("At what miles does your #{name} need to be done?")
    while mileage.strip.empty? or mileage.to_i < 0
      say("'#{mileage}' is not valid input")
      mileage = ask("At what miles does your #{name} need to be done?")
    end
    mileage = mileage.to_i
    car_index -= 1
    car_id = cars[car_index].id
    response = self.add(car_id, name, mileage)
    say(response) unless response.nil?
  end

  def edit_task
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
    car_id = cars[car_index].id
    say("What task would you like to edit? (or type exit to leave)")
    say(self.index(car_id))
    task_index = ask('')
    task = Task.all(car_id)
    if task_index == "exit"
      return
    end
    while task_index.to_i < 1 or task_index.to_i > task.length
      say("#{task_index} is not a valid choice")
      say("What task would you like to edit? (or type exit to leave)")
      say(self.index(car_id))
      task_index = ask('')
      if task_index == "exit"
        return
      end
    end
    task_index = task_index.to_i - 1
    task = task[task_index]
    old_name = task.name
    old_mileage = task.mileage
    choice = ask("What would you like to edit: name, mileage, or completion")
    if choice == "name"
      task.name = ask("Please enter the updated name").strip
      while task.name.empty?
        say("\"#{task.name}\" is not acceptable input")
        task.name = ask("Please enter the updated name").strip
      end
    elsif choice == "mileage"
      task.mileage = ask("Please enter the updated mileage").strip.to_i
      while task.mileage.zero?
        say("\"#{task.mileage}\" is not acceptable input")
        task.mileage = ask("Please enter the updated mileage").strip.to_i
      end
    elsif choice == "completion"
      task.completed = ask("Mark task as completed? (y/n)")
      if task.completed == "y"
        task.completed = 1
      else
        task.completed = 0
      end
    elsif choice == "exit"
      return
    end
    if choice == "name" and task.save
      say("\n\n#{old_name} name changed to #{task.name}\n\n")
      return
    else
      say("#{task.errors}")
    end
    if choice == "mileage" and task.save
      say("\n\n#{task.name} mileage changed from #{old_mileage} to #{task.mileage}\n\n")
      return
    else
      say("#{task.errors}")
    end
    if choice == "completion" and task.save
      say("\n\n#{task.name} marked as completed\n\n")
      return
    else
      say("#{task.errors}")
    end
  end

  def delete_task
    cars = Car.all
    cars_controller = CarsController.new
    say("From wich car?")
    say(cars_controller.index)
    car_index = ask('')
    if car_index == "exit"
      return
    end
    while car_index.to_i < 1 or car_index.strip.empty? or car_index.to_i > cars.length
      say("'#{car_index}' is not valid input")
      say("From which car?")
      say(cars_controller.index)
      car_index = ask('')
      if car_index == "exit"
        return
      end
    end
    car_index = car_index.to_i - 1
    car_id = cars[car_index].id
    say("Which task would you like to delete?")
    say(self.index(car_id))
    task_index = ask('')
    tasks = Task.all(car_id)
    if task_index == "exit"
      return
    end
    while task_index.to_i < 1 or task_index.to_i > tasks.length
      say("#{task_index} is not a valid choice")
      say("Which task would you like to delete?")
      say(self.index(car_id))
      task_index = ask('')
      if task_index == "exit"
        return
      end
    end
    task_index = task_index - 1
    task = tasks[task_index]
    confirmation = ask("Are you sure you want to delete the #{task.name} scheduled at #{task.mileage}?(y/n)")
    if confirmation.upcase == "Y"
      Task.delete(task.id)
      say("\n\n#{task.name} at #{task.mileage} deleted")
    else
      say("Deletion canceled")
    end
  end
end
