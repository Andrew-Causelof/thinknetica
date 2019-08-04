#Заполнить хеш гласными буквами,
#где значением будет являтся порядковый номер буквы в алфавите (a - 1).

alphabets = Hash[("a".."z").to_a.zip((1..26).to_a)]
output = alphabets.select{|k, v| k == "a" || k == "e" || k == "i" || k == "o" || k == "u" }
puts output
