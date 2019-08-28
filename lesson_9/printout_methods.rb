module Printout
  # Options, text for general menu
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

  def press_enter
    puts 'Для продолжения нажмите enter'
    gets
  end

  # List out trains for the further
  def printout_trains(trains)
    system("clear")
    if !trains.empty?
      puts 'Выберете поезд из списка:'
      trains.each_index do |x|
        print "#{x}. Номер : #{trains[x].number}, "
        print "Тип : #{trains[x].type}, "
        puts  "Вагонов в поезде : #{trains[x].wagons.length}"
      end
    else
      puts 'В списках нет ни одного поезда, необходимо создать!'
    end
  end

  # List out Stations for the further
  def printout_stations_by_number(stations)
    if stations.size <= 1
      system("clear")
      puts 'Не достаточно станций для работы с  маршрутом'
    else
      stations.each_index { |x| puts "#{x}. Станция : #{self.stations[x].name}" }
    end
  end

  # List out routes for the further
  def printout_routes(routes)
    if routes.empty?
      puts "Нет маршрутов для редактирования"
    else
      routes.each_index { |x| puts "#{x}. Маршрут : #{routes[x].name}" }
    end
  end

  # Method prints Stations, and trains/wagons that came
  def printout_data_for_stations(stations)
    system("clear")
    stations.each do |x|
      puts " На станции #{x.name} поезда : "
      if !x.trains.empty?
        x.each_train do |train|
          print " Поезд с номером : #{train.number}, "
          print " Тип : #{train.type}, "
          puts " Вагонов : #{train.wagons.size}"
            if !train.wagons.empty?
              train.print_out_passenger_wagon if train.type == 'пассажирский'
              train.print_out_cargo_wagon if train.type == 'грузовой'
            end
        end
      else
        puts ' Поездов нет'
      end
    end
    press_enter
  end

  def wagons_list(trains)
    printout_trains(trains)
    read_train = gets.chomp.to_i
    train = trains[read_train]
    puts " Поезд с номером №#{train.number}, состоит из вагонов: "
    if !train.wagons.empty?
      train.print_out_passenger_wagon if train.type == 'пассажирский'
      train.print_out_cargo_wagon if train.type == 'грузовой'
    else
      puts ' К поезду не подцеплены вагоны'
    end
    press_enter
  end
end
