particles = {}

File.open('./input') do |file|
  file.each_line do |line|
    particle = line.chomp
    parts = particle.split(', ')
    particles[file.lineno-1] = [parts[0][3..-2].split(','), parts[1][3..-2].split(','), parts[2][3..-2].split(',')]
  end
end

particles.keys.each do |particle|
  particles[particle].each_index do |component|
    (0..2).each { |i| particles[particle][component][i] = particles[particle][component][i].to_i}
  end
end

def quadratic(accel, vel, pos, t)
  return accel*t*(t+1)*0.5 + vel*t + pos
end

positions, velocities, accelerations, pos_at_t = {},{},{},{}
particles.each do |key,val|
  positions[key] = val[0]
  pos_at_t[key] = val[0]
  velocities[key] = val[1]
  accelerations[key] = val[2]
end

(1..100).each do |t|
  #p "position at #{t}:  #{pos_at_t}"
  #p "accelerations:  #{accelerations}"
  #p "velocities: #{velocities}"
  positions.keys.each do |i|
    x = quadratic(accelerations[i][0], velocities[i][0], positions[i][0], t)
    y = quadratic(accelerations[i][1], velocities[i][1], positions[i][1], t)
    z = quadratic(accelerations[i][2], velocities[i][2], positions[i][2], t)
    pos_at_t[i] = [x,y,z]
  end
  pos_at_t.values.each do |i|
    if pos_at_t.values.count(i) > 1
      pos_at_t.delete_if { |key, val| val == i }
    end
  end
  collided = positions.keys - pos_at_t.keys
  collided.each do |i|
    positions.delete(i)
    #puts "deleted particle #{i}"
  end

end

puts pos_at_t[71]
puts pos_at_t[72]

puts "#{pos_at_t.count} uncollided particles"
