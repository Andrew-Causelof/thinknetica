require_relative './station.rb'
require_relative './route.rb'
require_relative './body.rb'
require_relative './factory'
require_relative './instance_counter'
require_relative './train.rb'
require_relative './cargo_train.rb'
require_relative './passenger_train.rb'
require_relative './wagon.rb'
require_relative './cargo_wagon.rb'
require_relative './passenger_wagon.rb'

start = Main.new

start.stations << Station.new('Moscow')
start.stations << Station.new('Novogireevo')
start.stations << Station.new('Geleznodorogny')
start.stations << Station.new('Pavlovsky Posad')

start.routes << Route.new('PP',start.stations[0].name, start.stations[3].name)
start.routes[0].add(start.stations[1].name)

start.trains << PassengerTrain.new('К713')
start.trains << PassengerTrain.new('А45')
start.trains << CargoTrain.new(366)
start.trains << CargoTrain.new(577)

start.menu
