#!/usr/bin/env ruby

def get_antipode(array, index)
  if index < array.length/2
    array[index + array.length/2]
  else
    array[index - array.length/2]
  end
end

number = ''
File.open('./day1.input') do |input|
  number = input.readline.chomp
end
digits = number.to_s.split('')
sum = 0

digits.each_index do |index|
  if digits[index] == get_antipode(digits, index)
      sum += digits[index].to_i
  end
end

puts sum
