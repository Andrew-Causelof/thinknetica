class CargoTrain < Train
  attr_reader :type
  def initialize(number)
    @type = 'грузовой'
    super
  end

  def add_wagon(wagon)
    if wagon.type == @type
      super
    else
      puts 'Нельзя подцеплять пассажирский вагон к грузовому поезду'
    end
  end
end
