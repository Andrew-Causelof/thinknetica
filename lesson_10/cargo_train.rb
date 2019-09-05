# CargoTrain contains methods for cargo trains, cos we have 2 kind of trains
# we had to separate it by 2 classes, Cargo and PassengerTrain
class CargoTrain < Train
  include Validation
  attr_reader :type
  validate :number, :format, FORMAT_TRAIN
  def initialize(number)
    @type = 'грузовой'
    super
  end

  def add_wagon(wagon)
    super if wagon.type == @type
  end

  def print_out_cargo_wagon
    each_wagon do |wagon|
      print "#{wagon.type} "
      print " вагон: #{wagon.name}"
      puts " в котором #{wagon.capacity} кубических метров, из которых"
      print "#{wagon.free_volume} свободных"
      puts "#{wagon.taken_volume} загружено"
    end
  end
end
