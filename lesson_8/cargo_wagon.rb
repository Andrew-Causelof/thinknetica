# Создаем класс -  грузовые вагоны
class CargoWagon < Wagon
  attr_reader :capacity, :taken_volume, :name

  def initialize(qty = 1, type = 'грузовой', capacity = 100)
    @capacity = capacity
    @taken_volume = 0
    @name = "C #{rand(100..999).to_s}"
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
