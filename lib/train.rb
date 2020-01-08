class Train
  attr_reader :id
  attr_accessor :name, :city_id


  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @city_id = attributes.fetch(:city_id)
  end


  def self.all
    returned_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    returned_trains.each() do |train|
      name = train.fetch("name")
      id = train.fetch("id").to_i
      city_id = train.fetch("city_id").to_i
      trains.push(Train.new({:name => name, :id => id, :city_id => city_id}))
    end
    trains
  end

  def save
    result = DB.exec("INSERT INTO trains (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(train_to_compare)
    self.name().downcase().eql?(train_to_compare.name.downcase())
  end

  def self.clear
    DB.exec("DELETE FROM trains *;")
  end

  def self.find(id)
    train = DB.exec("SELECT * FROM trains WHERE id = #{id};").first
    name = train.fetch("name")
    id = train.fetch("id").to_i
    city_id = train.fetch("city_id")
    Train.new({:name => name, :id => id, :city_id => city_id})
  end

    def self.search(train_name)
      trains = []
      returned_trains = DB.exec("SELECT * FROM trains WHERE name LIKE '#{train_name}%';")
      returned_trains.each() do |train|
        name = train.fetch("name")
        id = train.fetch("id").to_i
        city_id = train.fetch("city_id").to_i
        trains.push(Train.new({:name => name, :id => id, :city_id => city_id}))
      end
      trains
    end

  def songs
    Song.find_by_train(self.id)
  end

  def update(name)
    @name = name
    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
  DB.exec("DELETE FROM trains WHERE id = #{@id};")
end
end
