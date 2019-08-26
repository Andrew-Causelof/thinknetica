require_relative './validator.rb'

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
      puts 'Для выхода из программы нажмите ctrl+c или 0'
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
        wagons_list
      when 9
        take_wagon_space
      when 0
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
    puts '8 - Вывести список вагонов у поезда'
    puts '9 - Занять место в поезде или обьем в вагоне'
    puts '0 - Выход'
    gets.chomp.to_i
  end

# Создаем станци до стоп слова
  def create_stations
    system ("clear")
    puts 'Введите название станции, для завершения введите exit'
    loop do
        name = gets.chomp.to_s
        begin
          name == 'exit' ? break : @stations << Station.new(name)
        rescue ArgumentError => e
          puts "Ошибка при создании станции: #{e.message}."
        end
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
      begin
        if train == 1
          @trains << PassengerTrain.new(number)
          wagons.times { |x| @trains.last.add_wagon(PassengerWagon.new())}
        else
          @trains << CargoTrain.new(number)
          wagons.times { |x| @trains.last.add_wagon(CargoWagon.new())}
        end
      rescue ArgumentError => e
        puts "Ошибка при создании поезда: #{e.message}."
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
      begin
        @routes << Route.new(name, begins, ends)
      rescue ArgumentError => e
        system ("clear")
        puts "Ошибка при создании маршрута: #{e.message}."
      end
      press_enter
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
          puts 'Введите число мест в вагоне:'
          seats = gets.chomp.to_i
          wagon = PassengerWagon.new(1, 'пассажирский', seats)
       else
         puts 'Введите обьем кубов в вагоне:'
         capacity = gets.chomp.to_i
         wagon = CargoWagon.new(1, 'грузовой', capacity)
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
      end

    else
      puts "Необходимо установить маршрут!"
      setup_route_for_train(read_train)
      self.move_train
    end
  end
# Метод выводит Станции и поезда на этих станциях
  def printout_datas
    system("clear")
    stations.each do |x|
      puts " На станции #{x.name} поезда : "
      if x.trains.length > 0
        x.each_train do |train|
          print " Поезд с номером : #{train.number}, "
          print " Тип : #{train.type}, "
          puts " Вагонов : #{train.wagons.size}"
            if train.wagons.size > 0
              print_out_passenger_wagon(train) if train.type == 'пассажирский'
              print_out_cargo_wagon(train) if train.type == 'грузовой'
            end
        end
      else
        puts ' Поездов нет'
      end
    end
    press_enter
  end

  def wagons_list
    printout_trains
    read_train = gets.chomp.to_i
    puts " Поезд с номером №#{@trains[read_train].number}, состоит из вагонов: "
    if @trains[read_train].wagons.size > 0
      print_out_passenger_wagon(@trains[read_train]) if @trains[read_train].type == 'пассажирский'
      print_out_cargo_wagon(@trains[read_train]) if @trains[read_train].type == 'грузовой'
    else
      puts ' К поезду не подцеплены вагоны'
    end
    press_enter
  end

  def take_wagon_space
    printout_trains
    read_train = gets.chomp.to_i
    train = @trains[read_train]
    if train.wagons.size > 0
      system("clear")
      puts "Выберете вагон :"
      index = 1
      train.each_wagon do |wagon|
        puts "#{index}. Вагон: #{wagon.name} "
        index += 1
      end
      read_wagon = gets.chomp.to_i - 1
      wagon = train.wagons[read_wagon]
      system("clear")
      print "#{wagon.type} "
      puts " вагон: #{wagon.name}"
      if wagon.type == 'пассажирский'
        wagon.take_seat
         puts " Один Пассажир добавлен!"
         press_enter
      else
        puts "Введите значение, чтобы наполнить вагон"
        read_value = gets.chomp.to_i
        wagon.load(read_value)
        puts "Вагон загружен"
        press_enter
      end
    else
      puts ' К поезду не подцеплены вагоны'
      press_enter
    end
  end


private
 # Выводим данные по вагонам пассажирского поезда
 def print_out_passenger_wagon(train)
   train.each_wagon do |wagon|
     print "#{wagon.type} "
     print " вагон: #{wagon.name}"
     puts " в котором #{wagon.seats} мест, из которых"
     print "#{wagon.free_seats} мест свободных и "
     puts "#{wagon.seats_taken} мест занято"
   end
 end

 # Выводим данные по вагонам грузового поезда
 def print_out_cargo_wagon(train)
   train.each_wagon do |wagon|
     print "#{wagon.type} "
     print " вагон: #{wagon.name}"
     puts " в котором #{wagon.capacity} кубических метров, из которых"
     print "#{wagon.free_volume} свободных"
     puts "#{wagon.taken_volume} загружено"
   end
 end

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
