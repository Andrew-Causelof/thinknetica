class Main
  attr_reader :stations, :trains, :routes
  def initialize
    @stations = []
    @trains   = []
    @routes   = []
  end
# Основное меню -интерфейс для взаимодействия с оператором
  def menu
    loop do
      system("clear")
      puts 'Для выхода из программы нажмите ctrl+c или 8'
      puts 'Выберете номер из меню :'
      case choose_option
      when 1
        create_stations
      when 2
        create_trains
      when 3
        manage_route
      when 4
        add_wagons
      when 5
        remove_wagons
      when 6
        move_train
      when 7
        printout_datas
      when 8
        break
      end
    end
  end
# Вспомогательный метод, вывода опций в меню
  def choose_option
    puts '1 - Создать станции'
    puts '2 - Создать поезда'
    puts '3 - Создать маршруты и управлять станцими в нем (добавлять, удалять)'
    puts '4 - Добавить вагон к поезду'
    puts '5 - Отцепить вагон от поезда'
    puts '6 - Переместить поезд по маршруту вперед / назад'
    puts '7 - Просмотреть список станций и список поездов на станции'
    puts '8 - Выход'
    gets.chomp.to_i
  end

# Создаем станци до стоп слова
  def create_stations
    system ("clear")
    puts 'Введите название станции, для завершения введите exit'
    loop do
      name = gets.chomp.to_s
      name == 'exit' ? break : @stations << Station.new(name)
    end
  end

# Создаем поезда
  def create_trains
    system ("clear")
    puts 'Для завершения ввода введите exit'
    loop do
      puts 'Введите номер поезда:'
      number = gets.chomp.to_s
      number == 'exit' ? break : number.to_i
      puts '1. Создать пассажирский поезд'
      puts '2. Создать грузовой поезд'
      train = gets.chomp.to_i
      puts 'Введите число вагонов:'
      wagons = gets.chomp.to_i
      if train == 1
      @trains << PassengerTrain.new(number)
      wagons.times { |x| @trains.last.add_wagon(PassengerWagon.new())}
      else
      @trains << CargoTrain.new(number)
      wagons.times { |x| @trains.last.add_wagon(CargoWagon.new())}
      end
    end
  end
# Создание маршрута, добавление, удаление станций из маршрута
  def manage_route
    system ("clear")
    puts '1. Создать маршрут'
    puts '2. Редактировать маршрут'
    input = gets.chomp.to_i
    case input
    when 1
      system ("clear")
      puts 'Введите название маршрута'
      name = gets.chomp.to_s
      puts 'Выберете станцию начала маршрута:'
      printout_stations_by_number
      begins = @stations[gets.chomp.to_i].name
      puts "Маршрут начинается со станции #{begins}"
      puts 'Выберете станцию окончания маршрута:'
      ends = @stations[gets.chomp.to_i].name
      puts "Маршрут заканчивается станцией #{ends}"
      @routes << Route.new(name, begins, ends)
    when 2
      #редактирование маршрута
      puts 'Выберете маршрут для редактирования'
      printout_routes
      revising_index = gets.chomp.to_i
      system("clear")

      puts '1. Добавить станцию'
      puts '2. Удалить станцию'

        if gets.chomp.to_i == 1
          system("clear")
          puts ' Выберете станцию которую добавляем:'
          printout_stations_by_number
          read_station = gets.chomp.to_i
          station = @stations[read_station].name
          puts "Добавляем в маршрут #{@routes[revising_index].name} станцию #{station} "
          @routes[revising_index].add(station)
          puts " Станция добавлена в маршрут, итоговый лист :"
          @routes[revising_index].stations.each { |x| puts "Станция #{x}" }
          press_enter
        else
          system("clear")
          puts 'Выберете станцию которую удаляем:'
          @routes[revising_index].stations.each_index {
            |x| puts "#{x}. Станция: #{@routes[revising_index].stations[x]}"
          }
          read_station = gets.chomp.to_i
          station = @stations[read_station].name
          puts "Удаляем из маршрута #{@routes[revising_index].name} станцию #{station} "
          @routes[revising_index].delete(station)
          press_enter
        end
    end
  end
# Метод добавляет вагон
  def add_wagons
    if @trains.length > 0
      puts '1. Создать пассажирский вагон'
      puts '2. Создать грузовой вагон'
      wagon_choice = gets.chomp.to_i
       if wagon_choice == 1
          wagon = PassengerWagon.new()
       else
          wagon = CargoWagon.new()
       end
      printout_trains
      read_train = gets.chomp.to_i
      @trains[read_train].add_wagon(wagon)
      press_enter    
    else
      puts 'Нет созданых поездов, к которым можно добавить вагоны'
      press_enter
    end
  end
# Метод удаляет вагон
  def remove_wagons
    printout_trains
    read_train = gets.chomp.to_i
      if @trains.length > 0 && @trains[read_train].wagons.length > 0
         @trains[read_train].remove
         puts 'Вагон удален'
         print "Вагонов в поезде номер #{@trains[read_train].number} :"
         puts "#{@trains[read_train].wagons.length}"
         press_enter
      else
        puts 'Нет созданых поездов, у которых можно отцепить вагоны'
        press_enter
      end
  end
# Метод перемещает поезда по маршруту, если не инициирован , то устанавливает
  def move_train
    printout_trains
    read_train = gets.chomp.to_i
    if @trains[read_train].route_check_true
      puts 'Выберете номер 1/2:'
      puts '1. Движение вперед по маршруту'
      puts '2. Движение назад по маршруту'
      case gets.chomp.to_i
      when 1
        # поезд уезжает - удаляем поезд из станции
        station_delete_train(read_train)
        @trains[read_train].ahead
        station_add_train(read_train)
      when 2
        station_delete_train(read_train)
        @trains[read_train].backward
        station_add_train(read_train)
      else
        puts 'Не корректный выбор'
        press_enter
      end

    else
      puts "Необходимо установить маршрут!"
      setup_route_for_train(read_train)
      self.move_train
    end
  end
# Метод выводит Станции и поезда на этих станциях
  def printout_datas
    stations.each { |x|
      puts " На станции #{x.name} поезда : "
      if x.trains.length > 0
        x.trains.each { |train| puts " Поезд с номером : #{train.number}" }
      else
        puts " Поездов нет"
      end
    }
    press_enter
  end


private

 # Метод удаляет поезд со станции
  def station_delete_train(train_index)
    @stations.each { |x|
    if x.name == @trains[train_index].current_station
      x.departure(@trains[train_index])
    end
     }
  end
# Метод добавляет поезд на станцию
  def station_add_train(train_index)
    @stations.each { |x|
    if x.name == @trains[train_index].current_station
      x.coming(@trains[train_index])
    end
     }
  end
# Метод устанавливает маршрут для поезда
  def setup_route_for_train(train_index)
    printout_routes
    read_route = gets.chomp.to_i
    @trains[train_index].setup_route(@routes[read_route])
    puts "Маршрут #{@routes[read_route].name} установлен"
    # Уведомлаям станцию что пришел к ней поезд
    # Находим станцию в списке:
    @stations.each { |x|
    if x.name == @routes[read_route].stations.first
      x.trains << @trains[train_index]
      puts " Поезд #{@trains[train_index].number} добавлен на станцию #{x.name}"
    end
     }
  end
# Метод выводит список станций для выбора
  def printout_stations_by_number
    if @stations.length <= 1
      system("clear")
      puts 'Не достаточно станций для работы с  маршрутом'
      self.menu
    else
      @stations.each_index { |x| puts "#{x}. Станция : #{self.stations[x].name}" }
    end
  end
# Метод выводит список маршрутов для выбора
  def printout_routes
    if @routes.length < 1
      puts "Нет маршрутов для редактирования"
      self.menu
    else
      @routes.each_index { |x| puts "#{x}. Маршрут : #{@routes[x].name}" }
    end
  end
# Метод выводит список поездов для выбора
  def printout_trains
    system("clear")
    if @trains.length > 0
      puts 'Выберете поезд из списка:'
      @trains.each_index { |x|
      print "#{x}. Номер : #{@trains[x].number}, "
      print "Тип : #{@trains[x].type}, "
      puts  "Вагонов в поезде : #{@trains[x].wagons.length}"
      }
    else
      puts "В списках нет ни одного поезда, необходимо создать!"
      self.create_trains
      self.menu
    end
  end
  def press_enter
    puts 'Для продолжения нажмите enter'
    gets
  end
end
