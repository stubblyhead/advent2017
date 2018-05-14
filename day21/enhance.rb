require 'deep_clone'

patterns = File.readlines('./testcase')
patterns.each_index do |line|
  patterns[line] = patterns[line].chomp.split(' => ')
  patterns[line].each_index do |i|
    patterns[line][i] = patterns[line][i].split('/')
    patterns[line][i].each_index { |j| patterns[line][i][j] = patterns[line][i][j].split('')}
  end
end

rulehash = {}
patterns.each do |i|
  base = i[0]
  transpose_base = DeepClone.clone(base.transpose)
  rotations_flips = []

  rotations_flips.push(base)
  rotations_flips.push(base.reverse)
  rotations_flips.push(DeepClone.clone(base).each { |j| j.reverse! })
  rotations_flips.push(DeepClone.clone(base.reverse).each { |j| j.reverse! })
  rotations_flips.push(transpose_base)
  rotations_flips.push(transpose_base.reverse)
  rotations_flips.push(DeepClone.clone(transpose_base).each { |j| j.reverse! })
  rotations_flips.push(DeepClone.clone(transpose_base.reverse).each { |j| j.reverse! })
  rotations_flips.uniq!
  rulehash[rotations_flips] = i[1]
end

rulehash.each { |key,val| puts "#{key} ==> #{val}"}
