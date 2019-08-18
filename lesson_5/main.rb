require_relative './train/train.rb'
require_relative './train/cargo_train.rb'
require_relative './train/passenger_train.rb'
require_relative './wagon/wagon.rb'
require_relative './wagon/cargo_wagon.rb'
require_relative './wagon/passenger_wagon.rb'
require_relative './station.rb'
require_relative './route.rb'
require_relative './body.rb'

start = Main.new

start.stations << Station.new('Moscow')
start.stations << Station.new('Novogireevo')
start.stations << Station.new('Geleznodorogny')
start.stations << Station.new('Pavlovsky Posad')

start.routes << Route.new('PP',start.stations[0].name, start.stations[3].name)
start.routes[0].add(start.stations[1].name)

start.trains << PassengerTrain.new('К713', 15)
start.trains << PassengerTrain.new('А45', 15)
start.trains << CargoTrain.new(366, 40)
start.trains << CargoTrain.new(577, 35)

start.menu
