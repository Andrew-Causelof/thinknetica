# CargoWagon contains methods for cargo wagons, cos we have 2 kind of trains and
# wagons, so we had to separate it by 2 classes, Cargo and Passenger
class CargoWagon < Wagon
  attr_reader :capacity, :taken_volume, :name

  def initialize(type = 'грузовой', capacity = 100)
    @capacity = capacity
    @taken_volume = 0
    @name = "C#{rand(100..999)}"
    super
  end

  def load(volume)
    if @taken_volume + volume <= @capacity
      @taken_volume += volume
    else
      @taken_volume = @capacity
    end
  end

  def free_volume
    @capacity - @taken_volume
  end
end
