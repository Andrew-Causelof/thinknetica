# Создаем родительский класс для всех вагонов
class Wagon
  attr_reader :type
  def initialize(qty = 1, type)
    @quantity = qty
    @type = type
  end
end
