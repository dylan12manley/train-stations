class City
  attr_reader :name, :id, :train_id


  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @train_id = attributes.fetch(:train_id)
  end


  def self.all
    returned_cities = DB.exec("SELECT * FROM cities;")
    cities = []
    returned_cities.each() do |city|
      name = city.fetch("name")
      id = city.fetch("id").to_i
      train_id = city.fetch("train_id").to_i
      cities.push(City.new({:name => name, :id => id, :train_id => train_id}))
    end
    cities
  end

  def save
    result = DB.exec("INSERT INTO cities (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(city_to_compare)
    self.name().downcase().eql?(city_to_compare.name.downcase())
  end

  def self.clear
    DB.exec("DELETE FROM cities *;")
  end

  def self.find(id)
    city = DB.exec("SELECT * FROM cities WHERE id = #{id};").first
    name = city.fetch("name")
    id = city.fetch("id").to_i
    train_id = city.fetch("train_id")
    City.new({:name => name, :id => id, :train_id => train_id})
  end

    def self.search(city_name)
      cities = []
      returned_cities = DB.exec("SELECT * FROM cities WHERE name LIKE '#{city_name}%';")
      returned_cities.each() do |city|
        name = city.fetch("name")
        id = city.fetch("id").to_i
        train_id = city.fetch("train_id").to_i
        cities.push(City.new({:name => name, :id => id, :train_id => train_id}))
      end
      cities
    end

    def update(attributes)
      if (attributes.has_key?(:name)) && (attributes.fetch(:name) != nil)
        @name = attributes.fetch(:name)
        DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{@id};")
      end
      train_id = attributes.fetch(:train_id)
      if train_id != nil
        trains = DB.exec("SELECT * FROM trains WHERE city_id = #{@id};")
        DB.exec("UPDATE trains_cities SET train_id = #{@train.id} WHERE id = #{@id};")
        if train != nil
          DB.exec("INSERT INTO trains_cities (city_id, train_id) VALUES (#{city['id'].to_i}, #{@id});")
      end
    end

  def delete
    DB.exec("DELETE FROM trains_cities WHERE train_id = #{@id};")
  DB.exec("DELETE FROM cities WHERE id = #{@id};")
  # add line
end
end
end
