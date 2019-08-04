# Заполнить массив числами от 10 до 100 с шагом 5
arr = [10]
while true do
  arr.last < 100 ? arr << arr[arr.length - 1] + 5 : break
end
puts arr
