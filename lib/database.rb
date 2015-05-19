require 'sqlite3'

class Database

  def self.load_structure
    Database.execute <<-SQL
    CREATE TABLE IF NOT EXISTS cars (
      id integer PRIMARY KEY AUTOINCREMENT,
      make varchar(50) NOT NULL,
      model varchar(50) NOT NULL,
      year integer NOT NULL,
      current_mileage_id integer,
      FOREIGN KEY (current_mileage_id) REFERENCES mileages (id)
    );
    SQL
    Database.execute <<-SQL
    CREATE TABLE IF NOT EXISTS tasks (
      id integer PRIMARY KEY AUTOINCREMENT,
      car_id integer,
      name varchar(20),
      mileage integer,
      completed boolean not null default 0,
      FOREIGN KEY (car_id) REFERENCES cars (id)
    );
    SQL
    Database.execute <<-SQL
    CREATE TABLE IF NOT EXISTS mileages (
      id integer PRIMARY KEY AUTOINCREMENT,
      car_id integer,
      mileage integer,
      date datetime DEFAULT (datetime('now','localtime')),
      FOREIGN KEY (car_id) REFERENCES cars (id)
    );
    SQL
  end

  def self.execute(*args)
    initialize_database unless defined?(@@db)
    @@db.execute(*args)
  end

  def self.initialize_database
    enviroment = ENV["TEST"] ? "test" : "production"
    database = "db/maintenance_tracker_#{enviroment}.sqlite"
    @@db = SQLite3::Database.new(database)
    @@db.results_as_hash = true
  end

end
