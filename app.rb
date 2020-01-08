require('sinatra')
require('sinatra/reloader')
require('./lib/city')
require('./lib/train')
require('pry')
require("pg")

DB = PG.connect({:dbname => "train_station"})

also_reload('lib/**/*.rb')

get('/') do
  @cities = City.all
  erb(:cities)
end

get('/cities') do
      @cities = City.all
      erb(:cities)
    end

get('/cities/new') do
  erb(:new_city)
end

post('/cities') do
  name = params[:city_name]
  city = City.new({:name => name, :id => id, :train_id => train_})
  city.save()
  @cities = City.all
  erb(:cities)
end

get('/cities/:id/edit') do
  @city = City.find(params[:id].to_i())
  erb(:edit_city)
end

patch('/cities/:id') do
  if !params[:name] && !params[:train_id]
    @city = City.find(params[:id].to_i())
    @cities = City.all
    erb(:cities)
  else
    @city = City.find(params[:id].to_i())
    @city.update(params[:name], params[:train_id])
    @cities = City.all
    erb(:city)
  end
end

delete('/cities/:id') do
  @city = City.find(params[:id].to_i())
  @city.delete()
  @cities = City.all
  erb(:cities)
end

get('/cities/search/') do
  @city = City.search(params[:searched])
  erb(:search)
end

get('/trains') do
  @trains = Train.all
  erb(:trains)
end

get('/trains/new') do
  erb(:new_train)
end

post '/trains' do
  name = params[:train_name]
  train = Train.new({:name => name, :id => nil, :city_id => nil})
  train.save
  @trains = Train.all
  erb(:trains)
end

get('/trains/:id/edit') do
  @train = Train.find(params[:id].to_i())
  erb(:edit_train)
end

get('/trains/:id') do
  @train = Train.find(params[:id].to_i())
  erb(:train)
end

patch('/trains/:id') do
  if !params[:name]
    @train = Train.find(params[:id].to_i())
    @train.sold()
    @trains = Train.all
    erb(:trains)
  else
    @train = Train.find(params[:id].to_i())
    @train.update(params[:name])
    @trains = Train.all
    erb(:train)
  end
end
