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
require_relative './validator.rb'

start = Main.new

start.stations << Station.new('Moscow')
start.stations << Station.new('Novogireevo')
start.stations << Station.new('Geleznodorogny')
start.stations << Station.new('Pavlovsky Posad')

start.routes << Route.new('Pavlovsky Posad', start.stations[0].name, start.stations[3].name)
start.routes[0].add(start.stations[1].name)

start.trains << PassengerTrain.new('п11-01')
10.times { start.trains.last.add_wagon(PassengerWagon.new) }
start.trains << PassengerTrain.new('п22-02')
15.times { start.trains.last.add_wagon(PassengerWagon.new) }
start.trains << CargoTrain.new('п22-01')
35.times { start.trains.last.add_wagon(CargoWagon.new) }
start.trains << CargoTrain.new('пf3-02')
40.times { start.trains.last.add_wagon(CargoWagon.new) }

start.menu
