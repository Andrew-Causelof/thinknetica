class Route
  attr_reader :route

  def initialize(begins, ends)
    @route = [begins, ends]
  end

  def delete(station)
    station != @route.first && station != @route.last ? @route.delete(station) : nil
  end

  def add(station, previous_station = route[0]) # it needs to point the station which one goes before inserting
 @route.each{ |x| x == previous_station ? @route.insert( @route.index(previous_station) + 1, station) : next }
  end

end
