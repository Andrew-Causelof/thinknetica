class CargoTrain < Train
  attr_reader :type
  def initialize(number)
    @type = 'грузовой'
    super
  end

  def add_wagon(wagon)
    super if wagon.type == @type
  end
end
