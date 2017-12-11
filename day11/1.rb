input = []

File.open('./input') do |file|
  input = file.readline.chomp.split(',')
end

north_south = 0
east_west = 0

input.each do |i|
  case i
  when 'n'
    north_south += 1
  when 's'
    north_south -= 1
  when 'ne'
    north_south += 1
    east_west += 1
  when 'se'
    east_west += 1
  when 'sw'
    north_south -= 1
    east_west -= 1
  when 'nw'
    east_west -= 1
  end
end

steps = 0
if north_south > 0 && east_west > 0 || north_south < 0 && east_west < 0
  steps += [north_south.abs,east_west.abs].min
end
steps += (north_south - east_west).abs

puts steps
