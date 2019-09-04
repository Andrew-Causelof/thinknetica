require_relative './relative.rb'
require_relative './printout_methods.rb'
require_relative './accessors.rb'

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

# accessors.rb we are going to test right here, look below :
class Test_accessor
  extend Accessors
  attr_accessor_with_history :smth, :smthelse, :smthmore, :smthbig
end

a = Test_accessor.new
#a.smth = 1
#a.smth = 2
#a.smth = 3
puts _a.smth
gets

start.menu
