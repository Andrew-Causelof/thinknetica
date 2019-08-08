
class Train

  attr_reader :speed, :wagon, :current_station, :route
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
    @speed == 0 ? @wagon += 1 : nil
  end
  def remove
    @speed == 0 $$ @wagon > 0 ? @wagon -=1 : nil
  end
  def setup_route(set_route)
    @route = set_route
    @current_station = @route[0]
  end
  def previous_station
    @current_station == @route.first ? @current_station : @route[@route.index(@current_station) - 1]
  end
  def next_station
    @current_station == @route.last ? @current_station : @route[@route.index(@current_station) + 1]
  end
  def ahead
    @current_station = next_station if @current_station != @route.last
  end
  def backward
    @current_station = previous_station if @current_station != @route.first
  end
end
