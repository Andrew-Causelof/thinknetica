class PassengerTrain < Train
  attr_reader :wagons
  def initialize(number, wagon, type = 'пассажирский')
    super
    @wagons = []
    wagon.times { |x| @wagons << PassengerWagon.new() }
  end
  def add_wagon
    if @speed.zero?
      @wagon += 1
      @wagons << PassengerWagon.new()
    else
      nil
    end
  end

  def remove
    if @speed.zero? && @wagon > 0
      @wagon -= 1
      @wagons.shift
    else
      nil
    end
  end
end
