class CargoTrain < Train
  attr_reader :type
  def initialize(number)
    @type = 'грузовой'
    super
  end
end
