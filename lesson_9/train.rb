
require_relative './factory.rb'
require_relative './instance_counter.rb'
require_relative './validator.rb'

FORMAT_TRAIN = /^[а-яa-z|\d]{3}-?[a-z|\d]{2}$/i.freeze

# Class Train, describs what Train does
# it knows how to : brake, speedup, setup route, moves ahead or backward
# also knows its own previous and next station
class Train
  include Factory
  include InstanceCount
  include Validator
  @@trains ||= {}

  def self.find(number)
    @@trains[number]
  end

  attr_reader :speed, :current_station, :route, :number, :wagons
  def initialize(number)
    @number = number
    validate!
    @speed = 0
    @wagons = []
    @@trains[number] = self
    register_instance
  end

  def braking
    @speed.zero? ? 0 : @speed -= 10
  end

  def speedup
    @speed += 10
  end

  def setup_route(set_route)
    @route = set_route
    @current_station = @route.stations[0]
  end

  # Here we are setting previous station
  def previous_station
    unless @current_station == @route.stations.first
      @current_station = @route.stations[@route.stations.index(@current_station) - 1]
    end
  end

  # Here we are setting next station
  def next_station
    unless @current_station == @route.stations.last
      @current_station = @route.stations[@route.stations.index(@current_station) + 1]
    end
  end

  # Moving ahead if route is setted
  def ahead
    if self.route_check_true && @current_station != @route.stations.last
      @current_station = next_station
    end
  end

# Moving back if route is setted
  def backward
    if self.route_check_true && @current_station != @route.stations.first
      @current_station = previous_station
    end
  end

  def add_wagon(new_wagon)
    @wagons << new_wagon if @speed.zero?
  end

  def remove
    @wagons.shift if @speed.zero? && !@wagons.empty?
  end

  def each_wagon
    @wagons.each { |wagon| yield wagon }
  end

  def route_check_true
    @route.nil? ? false : true
  end

  private

  def validate!
    raise ArgumentError, 'Не верный формат поезда' if @number !~ FORMAT_TRAIN
  end
end
