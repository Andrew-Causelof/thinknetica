=begin
    Идеальный вес. Программа запрашивает у пользователя имя и рост и
     выводит идеальный вес по формуле <рост> - 110,
      после чего выводит результат пользователю на экран с обращением по имени.
       Если идеальный вес получается отрицательным, то выводится строка "Ваш вес уже оптимальный"
rescue => exception
=end

puts "Назовите Ваше Имя"  
user_name = gets.chomp 
puts "Какой у вас рост в сантиметрах?"
weight = Integer(gets) - 110

if weight <= 0 
  puts "#{user_name} Ваш вес уже оптимальный "
else
  puts "#{user_name} Ваш Идеальный вес #{weight} кг" 
end 


