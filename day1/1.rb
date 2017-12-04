number = ''
File.open('./day1.input') do |input|
  number = input.readline.chomp
end
digits = number.to_s.split('')
sum = 0

digits.each_index do |index|
  if index < digits.length - 1
    if digits[index] == digits[index + 1]
      sum += digits[index].to_i
  else
    if digits[index] == digits[0]
      sum += digits[index].to_i
    end
  end
end 

puts sum     
