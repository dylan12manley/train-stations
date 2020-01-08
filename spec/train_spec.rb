require 'rspec'
require 'train'
require('spec_helper')

describe '#Train' do

  describe('#save') do
    it("Saves train") do
      train = Train.new({:name => "pacoast express", :id => nil, :city_id => nil})
      train.save()
      train2 = Train.new({:name => "the slow express", :id => nil, :city_id => nil})
      train2.save()
      expect(Train.all).to(eq([train, train2]))
    end
  end

  describe('.all') do
    it("returns an empty array when there are no trains") do
      expect(Train.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same train if it has the same attributes as another train") do
      train = Train.new({:name => "pacoast express", :id => nil, :city_id => nil})
      train2 = Train.new({:name => "pacoast express", :id => nil, :city_id => nil})
      expect(train).to(eq(train2))
    end
  end
  #
  describe('.clear') do
    it('clears all trains') do
      train = Train.new({:name => "pacoast express", :id => nil, :city_id => nil})
      train.save()
      train2 = Train.new({:name => "the slow express", :id => nil, :city_id => nil})
      train2.save()
      Train.clear()
      expect(Train.all).to(eq([]))
    end
  end
  #
  describe('.find') do
    it("finds an train by id") do
      train = Train.new({:name => "pacoast express", :id => nil, :city_id => nil})
      train.save()
      train2 = Train.new({:name => "the slow express", :id => nil, :city_id => nil})
      train2.save()
      expect(Train.find(train.id)).to(eq(train))
    end
  end

  describe('#update') do
    it("updates an train by id") do
      train = Train.new({:name => "pacoast express", :id => nil, :city_id => nil})
      train.save()
      train.update("Blue")
      expect(train.name).to(eq("Blue"))
    end
  end

  describe('#delete') do
    it('deletes an train by id') do
      train = Train.new({:name => "pacoast express", :id => nil, :city_id => nil})
      train.save()
      train2 = Train.new({:name => "the slow express", :id => nil, :city_id => nil})
      train2.save()
      train.delete()
      expect(Train.all).to(eq([train2]))
    end
  end

  describe('.search') do
    it('searches for the given train name') do
      Train.clear()
      train = Train.new({:name => "pacoast express", :id => nil, :city_id => nil})
      train.save()
      train3 = Train.new({:name => "pacoast express", :id => nil, :city_id => nil})
      train3.save()
      train2 = Train.new({:name => "the slow express", :id => nil, :city_id => nil})
      train2.save()
      expect(Train.search("pacoast express")).to(eq([train, train3]))
    end
  end

end
