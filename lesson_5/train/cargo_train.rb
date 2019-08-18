class CargoTrain < Train

  def initialize(number, wagon, type = 'грузовой')
    super
    @wagons = []
    wagon.times { |x| @wagons << CargoWagon.new() }
  end

  def add_wagon(new_wagon)
    if @speed.zero?
      @wagon += 1
      @wagons << new_wagon
    else
      puts " Для добавления вагона остановите поезд!"
    end
  end

  def remove
    if @speed.zero? && @wagon > 0
      @wagon -= 1
      @wagons.shift
    else
      puts " Для добавления вагона остановите поезд!"
    end
  end
end
