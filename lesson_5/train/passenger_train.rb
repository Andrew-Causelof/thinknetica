class PassengerTrain < Train
  attr_reader :type
  def initialize(number)
    @type = 'пассажирский'
    super
  end
end