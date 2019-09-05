class PassengerTrain < Train
  include Validation
  attr_reader :type
  validate :number, :format, FORMAT_TRAIN
  def initialize(number)
    @type = 'пассажирский'
    super
  end

  def add_wagon(wagon)
    super if wagon.type == @type
  end

  def print_out_passenger_wagon
    each_wagon do |wagon|
      print "#{wagon.type} "
      print " вагон: #{wagon.name}"
      puts " в котором #{wagon.seats} мест, из которых"
      print "#{wagon.free_seats} мест свободных и "
      puts "#{wagon.seats_taken} мест занято"
    end
  end
end
