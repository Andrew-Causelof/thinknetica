class Route
  attr_reader :route

  def initialize(begins, ends)
    @route = [begins, ends]
  end

  def delete(station)
    route.delete(station) if station != route.first && station != route.last
  end

  def add(station, previous_station = route[0]) # it needs to point the station which one goes before inserting
    previous_station != @route.last ? @route.insert(@route.index(previous_station) + 1, station) : @route.insert(-1, station)
  end

end
