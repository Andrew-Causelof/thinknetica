
# Class Train, describs what Train does

require_relative './factory.rb'
require_relative './instance_counter.rb'

class Train
  include Factory
  include InstanceCount
  # @@trains = Set.new
  @@trains ||= {}

  def self.find(number)
    @@trains[number]
  end

  attr_reader :speed, :current_station, :route, :number, :wagons
  def initialize(number)
    @number = number
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
    if @current_station == @route.stations.first
      @current_station
    else
      @current_station = @route.stations[@route.stations.index(@current_station) - 1]
    end
  end
  # Here we are setting next station
  def next_station
    if @current_station == @route.stations.last
      @current_station
    else
      @current_station = @route.stations[@route.stations.index(@current_station) + 1]
    end
  end
# Moving ahead if route is setted
  def ahead
    if self.route_check_true
      if @current_station != @route.stations.last
        puts " Поезд уехал со станции #{@current_station}"
        @current_station = next_station
        puts "Поезд прибыл на станцию #{@current_station}"
      end
    end
  end
# Moving back if route is setted
  def backward
    if self.route_check_true
      if @current_station != @route.stations.first
        puts " Поезд уехал со станции #{@current_station}"
        @current_station = previous_station
        puts "Поезд прибыл на станцию #{@current_station}"
      end
    end
  end

  def add_wagon(new_wagon)
    if @speed.zero?
      @wagons << new_wagon
    else
      puts " Для добавления вагона остановите поезд!"
    end
  end

  def remove
    if @speed.zero? && @wagons.length > 0
      @wagons.shift
    else
      puts " Для добавления вагона остановите поезд!"
    end
  end

  def route_check_true
    if @route.nil?
      puts 'Маршрут не установлен!!!'
    else
      true
    end
  end
end
