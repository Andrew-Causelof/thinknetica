require_relative './class_route.rb'

class Train < Route

  attr_reader :speed, :wagon, :current_station

    @current_station
  def initialize(number, type = "пассажирский", wagon = 15)
    @number = number
    @type = type
    @wagon = wagon
    @speed = 0
  end

  def braking
    @speed == 0 ? 0 : @speed -= 10
  end

  def speedup
    @speed += 10
  end

  def add_wagon
    speed == 0 ? @wagon += 1 : nil
  end

  def remove
    speed == 0 ? @wagon -=1 : nil
  end

  def setup_route(set_route)
    self.route = set_route
    @current_station = self.route[0]
  end

  def previous_station
    @current_station == self.route.first ? @current_station : self.route[route.index(@current_station) - 1]
  end

  def next_station
    @current_station == self.route.last ? @current_station : self.route[route.index(@current_station) + 1]
  end

  def move (step = 1)  # moving ahead or back
    case step
    when step == 0
      nill
    when step > 0
      self.route.each { |x| x == @current_station && x != self.route.last ? @current_station = self.next_station : nil }
    when step < 0
      self.route.each { |x| x == @current_station && x != self.route.first ? @current_station = self.previous_station : nil }
    end
  end


end
