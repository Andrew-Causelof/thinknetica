#Заполнить массив числами фибоначчи до 100
arr = [0, 1]
while true do
  arr[-1] + arr[-2] < 100 ? arr << arr[-1] + arr[-2]: break
end
puts arr
