# Class Route, written for the Train railway, may accepts stations,
# delete stations, add stations
require_relative './instance_counter.rb'

class Route
  include InstanceCount

  attr_reader :stations, :name

  def initialize(name, begins, ends)
    @stations = [begins, ends]
    @name = name
    register_instance
  end

  def delete(station)
    @stations.delete(station) if station != @stations.first && station != @stations.last
  end
# it needs to point the station which one goes before inserting

  def add(station, previous_station = @stations.first)
    previous_station != @stations.last ? @stations.insert(@stations.index(previous_station) + 1, station) : @stations.insert(-1, station)
  end
end
