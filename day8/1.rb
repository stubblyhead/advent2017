input = <<END
b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10
END

instructions = input.split("\n")
variables = {}

instructions.each do |i|
  step = i.split(' if ')
  step[0].tr!('inc', '+=')
  step[0].tr!('dec', '-=')
  
