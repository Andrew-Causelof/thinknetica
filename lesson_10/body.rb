require_relative './printout_methods.rb'
require_relative './accessors.rb'
class Main
  include Printout
  extend Accessors
  attr_reader :stations, :trains, :routes
  def initialize
    @stations = []
    @trains   = []
    @routes   = []
  end

  def menu
    loop do
      system('clear')
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
        printout_data_for_stations(@stations)
      when 8
        wagons_list(@trains)
      when 9
        take_wagon_space
      when 0
        break
      end
    end
  end

  def new_method
    system('clear')
    puts 'smth'
  end

  def create_stations
    system('clear')
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

  def create_trains
    system('clear')
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
         wagons.times { @trains.last.add_wagon(PassengerWagon.new) }
       else
         @trains << CargoTrain.new(number)
         wagons.times { @trains.last.add_wagon(CargoWagon.new) }
       end
      rescue ArgumentError => e
        puts "Ошибка при создании поезда: #{e.message}."
     end
    end
  end

  def manage_route
    system('clear')
    puts '1. Создать маршрут'
    puts '2. Редактировать маршрут'
    input = gets.chomp.to_i
    case input
    when 1
      system('clear')
      puts 'Введите название маршрута'
      name = gets.chomp.to_s
      puts 'Выберете станцию начала маршрута:'
      printout_stations_by_number(@stations)
      begins = @stations[gets.chomp.to_i].name
      puts "Маршрут начинается со станции #{begins}"
      puts 'Выберете станцию окончания маршрута:'
      ends = @stations[gets.chomp.to_i].name
      puts "Маршрут заканчивается станцией #{ends}"
      begin
        @routes << Route.new(name, begins, ends)
      rescue ArgumentError => e
        system('clear')
        puts "Ошибка при создании маршрута: #{e.message}."
      end
      press_enter
    when 2
      # редактирование маршрута
      puts 'Выберете маршрут для редактирования'
      printout_routes(@routes)
      revising_index = gets.chomp.to_i
      system('clear')

      puts '1. Добавить станцию'
      puts '2. Удалить станцию'

      if gets.chomp.to_i == 1
        puts ' Выберете станцию которую добавляем:'
        printout_stations_by_number(@stations)
        read_station = gets.chomp.to_i
        station = @stations[read_station].name
        @routes[revising_index].add(station)
        puts ' Станция добавлена в маршрут, итоговый лист :'
        @routes[revising_index].stations.each { |x| puts "Станция #{x}" }
      else
        puts 'Выберете станцию которую удаляем:'
        @routes[revising_index].stations.each_index do |x|
          puts "#{x}. Станция: #{@routes[revising_index].stations[x]}"
        end
        read_station = gets.chomp.to_i
        station = @stations[read_station].name
        @routes[revising_index].delete(station)
      end
    end
    press_enter
  end

  def add_wagons
    if !@trains.empty?
      puts '1. Создать пассажирский вагон'
      puts '2. Создать грузовой вагон'
      wagon_choice = gets.chomp.to_i
      if wagon_choice == 1
        puts 'Введите число мест в вагоне:'
        seats = gets.chomp.to_i
        wagon = PassengerWagon.new('пассажирский', seats)
      else
        puts 'Введите обьем кубов в вагоне:'
        capacity = gets.chomp.to_i
        wagon = CargoWagon.new('грузовой', capacity)
      end
      printout_trains(@trains)
      read_train = gets.chomp.to_i
      @trains[read_train].add_wagon(wagon)
    else
      puts 'Нет созданых поездов, к которым можно добавить вагоны'
    end
    press_enter
  end

  def remove_wagons
    printout_trains(@trains)
    read_train = gets.chomp.to_i
    if !@trains.empty? && !@trains[read_train].wagons.empty?
      @trains[read_train].remove
      print "Вагонов в поезде номер #{@trains[read_train].number} :"
      puts @trains[read_train].wagons.length.to_s
    else
      puts 'Нет созданых поездов, у которых можно отцепить вагоны'
    end
    press_enter
  end

  def move_train
    printout_trains(@trains)
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
      puts 'Необходимо установить маршрут!'
      setup_route_for_train(read_train)
      move_train
    end
  end

  def take_wagon_space
    printout_trains(@trains)
    read_train = gets.chomp.to_i
    train = @trains[read_train]
    if !train.wagons.empty?
      system('clear')
      puts 'Выберете вагон :'
      index = 1
      train.each_wagon do |wagon|
        puts "#{index}. Вагон: #{wagon.name} "
        index += 1
      end
      read_wagon = gets.chomp.to_i - 1
      wagon = train.wagons[read_wagon]
      system('clear')
      print "#{wagon.type} "
      puts " вагон: #{wagon.name}"
      if wagon.type == 'пассажирский'
        wagon.take_seat
        puts ' Один Пассажир добавлен!'
      else
        puts 'Введите значение, чтобы наполнить вагон'
        read_value = gets.chomp.to_i
        wagon.load(read_value)
        puts 'Вагон загружен'
      end
    else
      puts ' К поезду не подцеплены вагоны'
    end
    press_enter
  end

  private

  def station_delete_train(train_index)
    @stations.each do |x|
      x.departure(@trains[train_index]) if x.name == @trains[train_index].current_station
    end
  end

  def station_add_train(train_index)
    @stations.each do |x|
      x.coming(@trains[train_index]) if x.name == @trains[train_index].current_station
    end
  end

  def setup_route_for_train(train_index)
    printout_routes(@routes)
    read_route = gets.chomp.to_i
    @trains[train_index].setup_route(@routes[read_route])
    puts "Маршрут #{@routes[read_route].name} установлен"
    # Note stations that train has come
    @stations.each do |x|
      if x.name == @routes[read_route].stations.first
        x.trains << @trains[train_index]
        puts " Поезд #{@trains[train_index].number} добавлен на станцию #{x.name}"
      end
    end
  end
end
