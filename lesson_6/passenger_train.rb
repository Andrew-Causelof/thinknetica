class PassengerTrain < Train
  attr_reader :type
  def initialize(number)
    @type = 'пассажирский'
    super
  end

  def add_wagon(wagon)
    if wagon.type == @type
      super
    else
      puts 'Нельзя подцеплять грузовой вагон к пассажирскому поезду'
    end
  end
end
