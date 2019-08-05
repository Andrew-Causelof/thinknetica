=begin
6. Сумма покупок. Пользователь вводит поочередно название товара,
 цену за единицу и кол-во купленного товара (может быть нецелым числом).
 Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп" в качестве названия товара.
  На основе введенных данных требуетеся:
Заполнить и вывести на экран хеш, ключами которого являются названия товаров,
а значением - вложенный хеш, содержащий цену за единицу товара и кол-во купленного товара.

Также вывести итоговую сумму за каждый товар.

Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".
=end
purchases = {}

while true do
  puts "Введите название товара :"
  goods = gets.chomp
  if %w[stop стоп].include?(goods.downcase)
    break
  else
    puts "Введите стоимость за единицу товара :"
    price = gets.chomp.to_f
    puts "Введите количество купленного товара :"
    qty = gets.chomp.to_f
    purchases[goods] = { price: price, qty: qty }
 end
end

puts "Итоговый хеш с ключами :"
puts purchases

puts "Итоговая сумма за каждый товар :"
purchases.keys.each { |key| puts "Сумма покупки #{key} = #{purchases[key][:price] * purchases[key][:qty]} " }

total = 0;
purchases.keys.each { |key| total = total + purchases[key][:price] * purchases[key][:qty] }
print "Итоговая сумма всех покупок: #{total}"
