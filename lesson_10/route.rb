require_relative './instance_counter.rb'
require_relative './validator.rb'
require_relative './validation.rb'
require_relative './accessors.rb'
FORMAT_ROUTE = /^[а-яА-Яa-zA-Z|\s]{3,}$/i.freeze
# Class Route, written for the Train railway, may accepts stations,
# delete stations, add stations
class Route
  include InstanceCount
  include Validator
  include Validation
  extend Accessors

  attr_reader :stations, :name, :first_station, :last_station

  validate :first_station, :validate_type, String
  validate :last_station, :validate_type, String

  def initialize(name, begins, ends)
    @first_station = begins
    @last_station = ends
    @stations = [begins, ends]
    @name = name
    validate!
    register_instance
  end

  def delete(station)
    @stations.delete(station) if station != @stations.first && station != @stations.last
  end

  def add(station, previous_station = @stations.first)
    if previous_station != @stations.last
      @stations.insert(@stations.index(previous_station) + 1, station)
    else
      @stations.insert(-1, station)
    end
  end

  def validate!
    raise ArgumentError, 'Название содержит только буквы длиной более 3х' if @name !~ FORMAT_ROUTE
  end
end
