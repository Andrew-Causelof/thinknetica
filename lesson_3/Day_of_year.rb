=begin
5. Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным.
(Запрещено использовать встроенные в ruby методы для этого вроде Date#yday или Date#leap?)
Алгоритм опредления високосного года: www.adm.yar.ru
=end

puts "Введите день месяца:"
  day = gets.chomp.to_i
puts "Введите месяц:"
  month = gets.chomp.to_i
puts "Введите год:"
  year = gets.chomp.to_i

if ((year % 4 == 0) && (year % 100 != 0)) || year % 400 == 0
  puts " ВИСОКОСНЫЙ год"
  days_array = [0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335]
else
  days_array = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334]
end

data = days_array[month - 1] + day
puts "Порядковый номер даты: #{data}"
