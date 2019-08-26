require_relative './instance_counter'
require_relative './validator.rb'

FormatStation = /^[а-яА-Яa-zA-Z|\s]{3,}$/i

class Station
  include InstanceCount
  include Validator

  @@stations = []

  def self.all
    @@stations
  end

  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def coming(train)
    @trains << train
  end

  def departure(train)
    @trains.delete(train)
  end

  def each_train
    @trains.each { |train| yield train }
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

  def validate!
    raise ArgumentError,'Название содержит только буквы и не короче 3 символов' if @name !~ FormatStation
  end

end
