
# Class Train, describs what Train does
class Train
  attr_reader :speed, :wagon, :current_station, :route
  def initialize(number, type = 'пассажирский', wagon = 15)
    @number = number
    @type = type
    @wagon = wagon
    @speed = 0
  end

  def braking
    @speed.zero? ? 0 : @speed -= 10
  end

  def speedup
    @speed += 10
  end

  def add_wagon
    @speed.zero? ? @wagon += 1 : nil
  end

  def remove
    @speed.zero? && @wagon > 0 ? @wagon -= 1 : nil
  end

  def setup_route(set_route)
    @route = set_route
    @current_station = @route.stations.first
  end
# Let's check has been route setted or not.
# If not returns message, if yes, returns - true
  def route_check_true
    if @route.nil?
      puts 'Маршрут не установлен!!!'
    else
      true
    end
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
        @route.stations[@route.stations.index(@current_station)].departure(self)
        @current_station = next_station
        @route.stations[@route.stations.index(@current_station)].coming(self)
      end
    end
  end
# Moving back if route is setted
  def backward
    if self.route_check_true
      if @current_station != @route.stations.first
        @route.stations[@route.stations.index(@current_station)].departure(self)
        @current_station = previous_station
        @route.stations[@route.stations.index(@current_station)].coming(self)
      end
    end
  end
end
