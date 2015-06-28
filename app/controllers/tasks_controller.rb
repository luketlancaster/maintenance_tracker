require 'highline/import'

class TasksController

  def index(car_id)
    if Task.count > 0
      tasks_string = ""
      Task.where(car_id: car_id).order(mileage: :asc).each_with_index do |task, index|
        if task.completed == false
          tasks_string << "#{index + 1}. #{task.name} at #{task.mileage} miles\n"
        elsif task.completed == true
          tasks_string << "#{index + 1}. √ #{task.name} at #{task.mileage} miles\n"
        end
      end
      tasks_string
    else
      return "No tasks found, add a task\n"
    end
  end

  def add(car_id, name, mileage)
    task = Task.new
    task.name = name
    task.mileage = mileage
    if task.save
      car =  Car.find(car_id)
      task.update(car_id: car_id)
      "#{name} for your #{car.year} #{car.make} #{car.model} scheduled at #{mileage} miles"
    else
      "#{task.errors}"
    end
  end

  def car_finder
    cars = Car.all
    cars_controller = CarsController.new
    say("For which car?")
    say(cars_controller.index)
    car_index = ask('')
    while car_index.to_i < 1 or car_index.to_i > cars.length
      say("#{car_index} is not a valid choice")
      say("For which car?")
      say(cars_controller.index)
      car_index = ask('')
    end
    car_index = car_index.to_i - 1
    cars[car_index].id
  end


  def list
    car_id = car_finder
    say("\n\n#{self.index(car_id)}\n\n")
    loop do
      continue = ask("Continue?(y/n)")
      if continue == 'y'
        break
      end
      say(self.index(car))
    end
  end

  def new_task
    car_id = car_finder
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
    response = self.add(car_id, name, mileage)
    say(response) unless response.nil?
  end

  def task_finder
    car_id = car_finder
    say("What task would you like to edit? (or type exit to leave)")
    say(self.index(car_id))
    task_index = ask('')
    tasks = Task.where(car_id: car_id).order(mileage: :asc)
    if task_index == "exit"
      return
    end
    while task_index.to_i < 1 or task_index.to_i > tasks.length
      say("#{task_index} is not a valid choice")
      say("What task would you like to edit? (or type exit to leave)")
      say(self.index(car_id))
      task_index = ask('')
      if task_index == "exit"
        return
      end
    end
    task_i = task_index.to_i - 1
    tasks[task_i]
  end

  def update_mileage(task_id, miles)
    task = Task.find_by(id: task_id)
    task.mileage = miles
    task.save
  end

  def edit_task
    task = task_finder
    old_name = task.name
    old_mileage = task.mileage
    choice = ask("What would you like to edit: name, mileage, or completion")
    if choice == "mileage"
      task.mileage = ask("Please enter the updated mileage").strip.to_i
      while task.mileage.zero?
        say("\"#{task.mileage}\" is not acceptable input")
        task.mileage = ask("Please enter the updated mileage").strip.to_i
      end
    elsif choice == "completion"
      completed = ask("Mark task as completed? (y/n)")
      if completed == "y"
        task.completed = true
      else
        task.completed = false
      end
    elsif choice == "name"
      task.name = ask("Please enter the updated name").strip
      while task.name.empty?
        say("\"#{task.name}\" is not acceptable input")
        task.name = ask("Please enter the updated name").strip
      end
    elsif choice == "exit"
      return
    end
    if choice == "name" and task.save
      say("\n\n#{old_name} name changed to #{task.name}\n\n")
      return
    elsif choice == "name"
      say("#{task.errors.full_messages}")
    end
    if choice == "mileage" and task.save
      say("\n\n#{task.name} mileage changed from #{old_mileage} to #{task.mileage}\n\n")
      return
    elsif choice == "mileage"
      say("#{task.errors.full_messages}")
    end
    if choice == "completion" and task.save
      say("\n\n#{task.name} marked as completed\n\n")
      return
    elsif choice == "completion"
      say("#{task.errors.full_messages}")
    end
  end

  def delete_task
    car_id = car_finder
    say("Which task would you like to delete?")
    say(self.index(car_id))
    task_index = ask('')
    tasks = Task.where(car_id: car_id)
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
    task_index = task_index.to_i - 1
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
