# Создаем класс -  пассажирские вагоны
class PassengerWagon < Wagon

attr_reader :seats_taken, :seats, :name

  def initialize(qty = 1, type = 'пассажирский', seats = 54)
    @seats = seats
    @seats_taken = 0
    @name = "P #{rand(100..999).to_s}"
    super
  end

  def take_seat
    @seats_taken += 1 if @seats_taken != @seats
  end

  def free_seats
    @seats - @seats_taken
  end

end
