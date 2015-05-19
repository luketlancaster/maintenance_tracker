class Mileage
  attr_reader :id, :errors, :car_id
  attr_accessor :mileage

  def self.all(car)
    Database.execute("SELECT * FROM mileages WHERE car_id == ? ORDER BY date", car).map do |row|
      miles = Mileage.new
      miles.mileage = row['mileage']
      miles.instance_variable_set(:@id, row['id'])
      miles.instance_variable_set(:@car_id, row['car_id'])
      miles
    end
  end

  def self.count
    Database.execute("SELECT COUNT(id) FROM mileages")[0][0]
  end

  def valid?
    unless @mileage.class == Fixnum and @mileage > 0
      @errors = "\"#{mileage}\" is not a valid mileage"
      false
    else
      @errors = nil
      true
    end
  end

  def save
    return false unless valid?
    Database.execute("INSERT INTO mileages (mileage, car_id) VALUES (?, ?)", mileage, car_id)
    @id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
    Database.execute("UPDATE cars SET current_mileage_id = ? WHERE id = ?", id, car_id)
    true
  end
end
