
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

# Takes type of train and returns quantity (wich ones have same type)

def type_qty(type)
sum = 0
  @trains.each do |train|
  sum += 1  if type.include?(@train.type)
  end
  if sum.zero?
    puts "В данный момент поездов с типом #{type} нет!"
  else
    puts " В данный момент поездов с типом #{type} : #{sum}"
  end
end
end
