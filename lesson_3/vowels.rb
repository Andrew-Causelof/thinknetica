#Заполнить хеш гласными буквами,
#где значением будет являтся порядковый номер буквы в алфавите (a - 1).

alphabets = Hash[("a".."z").to_a.zip((1..26).to_a)]
output = alphabets.select{ |k, v| %w[a e i o u].include?(k) }
puts output
