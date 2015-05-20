class Task
  attr_reader :id, :car_id, :errors
  attr_accessor :name, :mileage, :completed

  def self.all(car_id)
    Database.execute("SELECT * FROM tasks WHERE car_id = ? ORDER BY mileage", car_id).map do |row|
      populate_from_database(row)
    end
  end

  def self.count
    Database.execute("SELECT COUNT(id) FROM tasks")[0][0]
  end

  def self.find(car_id)
    Database.execute("SELECT * FROM tasks WHERE car_id = ?", car_id) do |row|
      if row.nil?
        nil
      else
        populate_from_database(row)
      end
    end
  end

  def self.populate_from_database(row)
    tasks = Task.new
    tasks.name = row['name']
    tasks.mileage = row['mileage']
    tasks.instance_variable_set(:@id, row['id'])
    tasks.instance_variable_set(:@car_id, row['car_id'])
    tasks
  end

  def valid?
    if !@mileage.class == Fixnum or @mileage.to_i < 1
      @errors = "\"#{mileage}\" is not a valid mileage"
      false
    elsif @name.strip.nil? or @name.strip.empty?
      @errors = "\"#{name}\" is not a valid task name"
      false
    else
      @errors = nil
      true
    end
  end

  def save
    return false unless valid?
    if @id.nil?
      Database.execute("INSERT INTO tasks(name, mileage, car_id) VALUES (?,?,?)", name, mileage, car_id)
      @id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
    else
      Database.execute("UPDATE tasks SET name = ?, mileage = ? WHERE id = ?", name, mileage, id)
    end
  end

  def delete(task_id)
    if task_id.nil?
      "Task not found"
    else
      Database.execute("DELETE FROM tasks WHERE id = ?", task_id)
    end
  end
end
