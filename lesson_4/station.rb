
class Station

attr_reader :trains

def initialize(name)
  @name = name
  @trains = []
end

def coming(train)
  @trains << train
end

def departure(train)
  @trains.delete(train)
end

def listing
  passenger = 0
  cargo = 0
  @trains.each do |train|
    puts "Поезда на станции :"
    puts "Номер поезда: #{train.number}, тип поезда : #{train.type}, вагонов в составе : #{train.wagon}"
    if %w[грузовой cargo].include?(train.type) cargo += 1
    if %w[пассажирский passenger].include?(train.type) passenger += 1
  end
puts "На станции #{@name} : #{cargo} грузовых поездов и #{passenger} пассажирских"
end

end
