require 'rspec'
require 'city'
require('spec_helper')

describe '#City' do

  describe('#save') do
    it("Saves city") do
      city = City.new({:name => "Portland", :id => nil, :train_id => nil})
      city.save()
      city2 = City.new({:name => "San Jose", :id => nil, :train_id => nil})
      city2.save()
      expect(City.all).to(eq([city, city2]))
    end
  end

  describe('.all') do
    it("returns an empty array when there are no cities") do
      expect(City.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same city if it has the same attributes as another city") do
      city = City.new({:name => "Portland", :id => nil, :train_id => nil})
      city2 = City.new({:name => "Portland", :id => nil, :train_id => nil})
      expect(city).to(eq(city2))
    end
  end
  #
  describe('.clear') do
    it('clears all cities') do
      city = City.new({:name => "Portland", :id => nil, :train_id => nil})
      city.save()
      city2 = City.new({:name => "San Jose", :id => nil, :train_id => nil})
      city2.save()
      City.clear()
      expect(City.all).to(eq([]))
    end
  end
  #
  describe('.find') do
    it("finds an city by id") do
      city = City.new({:name => "Portland", :id => nil, :train_id => nil})
      city.save()
      city2 = City.new({:name => "San Jose", :id => nil, :train_id => nil})
      city2.save()
      expect(City.find(city.id)).to(eq(city))
    end
  end

  describe('#update') do
    it("updates an city by id") do
      city = City.new({:name => "Portland", :id => nil, :train_id => nil})
      city.save()
      city.update("Blue")
      expect(city.name).to(eq("Blue"))
    end
  end

  describe('#delete') do
    it('deletes an city by id') do
      city = City.new({:name => "Portland", :id => nil, :train_id => nil})
      city.save()
      city2 = City.new({:name => "San Jose", :id => nil, :train_id => nil})
      city2.save()
      city.delete()
      expect(City.all).to(eq([city2]))
    end
  end

  describe('.search') do
    it('searches for the given city name') do
      City.clear()
      city = City.new({:name => "Portland", :id => nil, :train_id => nil})
      city.save()
      city2 = City.new({:name => "San Jose", :id => nil, :train_id => nil})
      city2.save()
      city3 = City.new({:name => "Portland", :id => nil, :train_id => nil})
      city3.save()
      expect(City.search("Portland")).to(eq([city, city3]))
    end
  end

end
