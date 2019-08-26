class PassengerTrain < Train
  attr_reader :type
  def initialize(number)
    @type = 'пассажирский'
    super
  end

  def add_wagon(wagon)
    super if wagon.type == @type
  end
end
