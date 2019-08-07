require_relative './class_train.rb'

class Station

attr_reader :train

def initialize(name)
  @name = name
  @train = []
end

def coming(train)
  @train << train
end

def departure(train)
  train.delete(train)
end

def listing
  @train.each do |train|
     puts "Номер поезда: #{train.number}, тип поезда: '#{train.type}', вагонов в составе: #{train.wagon}"
   end
end

end
