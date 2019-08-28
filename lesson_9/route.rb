require_relative './instance_counter.rb'
require_relative './validator.rb'

FORMAT_ROUTE = /^[а-яА-Яa-zA-Z|\s]{3,}$/i.freeze
# Class Route, written for the Train railway, may accepts stations,
# delete stations, add stations
class Route
  include InstanceCount
  include Validator
  attr_reader :stations, :name

  def initialize(name, begins, ends)
    @stations = [begins, ends]
    @name = name
    validate!
    register_instance
  end

  def delete(station)
    if station != @stations.first && station != @stations.last
      @stations.delete(station)
    end
  end

  def add(station, previous_station = @stations.first)
    if previous_station != @stations.last
      @stations.insert(@stations.index(previous_station) + 1, station)
    else
      @stations.insert(-1, station)
    end
  end

  def validate!
    if @name !~ FORMAT_ROUTE
      raise ArgumentError, 'Название содержит только буквы длиной более 3х'
    end
  end
end
