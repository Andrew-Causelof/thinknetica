# Here we create parental class for all kind of wagons
require_relative 'factory'
class Wagon
  include Factory
  attr_reader :type
  def initialize(type, _capacity)
    @type = type
  end
end
