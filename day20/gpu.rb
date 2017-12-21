particles = []

File.open('./testcase') do |file|
  file.each_line do |line|
    particles.push(line.chomp)
  end
end

accel_hash = {}
particles.each_index do |particle_idx|
  parts = particles[particle_idx].split(', ')
  accel = parts[2][3..-2].split(',')
  accel_hash[particle_idx] = Math::sqrt(accel[0].to_i**2 + accel[1].to_i**2 + accel[2].to_i**2)
end

min_accel = accel_hash.values.min
puts "lowest acceleration is #{min_accel} for particle #{accel_hash.key(min_accel)}"
