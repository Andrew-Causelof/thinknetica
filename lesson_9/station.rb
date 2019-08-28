require_relative './instance_counter'
require_relative './validator.rb'

FORMAT_STATION = /^[а-яА-Яa-zA-Z|\s]{3,}$/i.freeze
# Here we describe how Station is acting
# Station has name, accepts trains and push train count
# and knows how to validate new station
class Station
  include InstanceCount
  include Validator

  @@stations ||= []

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
    if @name !~ FORMAT_STATION
      raise ArgumentError, 'Название содержит только буквы длиной более 3х'
    end
  end
end
