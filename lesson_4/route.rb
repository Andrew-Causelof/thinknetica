# Class Route, written for the Train railway, may accepts stations,
# delete stations, add stations

class Route
  attr_reader :stations

  def initialize(begins, ends)
    @stations = [begins, ends]
  end

  def delete(station)
    @stations.delete(station) if station != @stations.first && station != @stations.last
  end
# it needs to point the station which one goes before inserting

  def add(station, previous_station = route[0])
    previous_station != @stations.last ? @stations.insert(@stations.index(previous_station) + 1, station) : @stations.insert(-1, station)
  end
end
