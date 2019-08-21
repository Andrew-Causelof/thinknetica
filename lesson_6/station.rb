require_relative './instance_counter'

class Station
  include InstanceCount

  @@stations = []

  def self.all
    @@stations
  end

  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end

  def coming(train)
    @trains << train
  end

  def departure(train)
    @trains.delete(train)
  end
# Takes type of train and returns quantity (wich ones have same type)
private

  def type_qty(type)
    sum = @trains.count(type)
    if sum.zero?
      puts "В данный момент поездов с типом #{type} нет!"
    else
      puts " В данный момент поездов с типом #{type} : #{sum}"
    end
  end
end
