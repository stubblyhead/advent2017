require 'prime'

num = 109900
prime_count = 0

while num < 126900
  prime_count += 1 if Prime.prime?(num)
  num += 17
  puts num
end

puts 1000 - prime_count
