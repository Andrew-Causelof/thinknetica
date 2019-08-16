# Создаем родительский класс для всех вагонов
class Wagon
  def initialize(qty = 1, type)
    @quantity = qty
    @type = type
  end
end
