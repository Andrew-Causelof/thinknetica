# Создаем родительский класс для всех вагонов
require_relative 'factory'
class Wagon
  include Factory
  attr_reader :type
  def initialize(qty = 1, type)
    @quantity = qty
    @type = type
  end
end
