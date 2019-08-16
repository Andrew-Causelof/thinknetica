
# Class Train, describs what Train does
class Train
  attr_reader :speed, :wagon, :current_station, :route, :number, :type
  def initialize(number, wagon = 15, type = 'пассажирский')
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
        sleep(1)
        @current_station = next_station
        puts "Поезд прибыл на станцию #{@current_station}"
        sleep(1)
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

  def route_check_true
    if @route.nil?
      puts 'Маршрут не установлен!!!'
    else
      true
    end
  end
end
