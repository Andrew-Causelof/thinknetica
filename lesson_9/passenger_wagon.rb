# PassengerWagon contains methods for passenger wagons, cos we have 2 kind
# of trains and wagons, so we had to separate it by 2 classes,
# Cargo and Passenger
class PassengerWagon < Wagon
  attr_reader :seats_taken, :seats, :name

  def initialize(type = 'пассажирский', seats = 54)
    @seats = seats
    @seats_taken = 0
    @name = "P#{rand(100..999)}"
    super
  end

  def take_seat
    @seats_taken += 1 if @seats_taken != @seats
  end

  def free_seats
    @seats - @seats_taken
  end
end
