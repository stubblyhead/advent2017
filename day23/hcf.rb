class Coprocessor
  attr_reader :registers, :mulcount, :instructions

  def initialize(instructions)
    @registers = Hash.new(0)
    ('a'..'h').each { |i| @registers[i] = 0 }
    @instructions = instructions
    @instruction_pointer = 0
    @mulcount = 0
  end

  def set(register, value)
    if value.class.to_s == 'Integer'
      @registers[register] = value
    else
      @registers[register] = @registers[value]
    end
  end

  def sub(register, value)
    if value.class.to_s == 'Integer'
      @registers[register] -= value
    else
      @registers[register] -= @registers[value]
    end
  end

  def mul(register, value)
    if value.class.to_s == 'Integer'
      @registers[register] *= value
    else
      @registers[register] *= @registers[value]
    end
    @mulcount += 1
  end

  def jnz(value, offset)
    value = @registers[value] unless value.class.to_s == 'Integer'
    if value != 0
      return offset
    else
      return 1
    end
  end

  def run
    until @instruction_pointer < 0 or @instruction_pointer >= @instructions.length
      inst = @instructions[@instruction_pointer]
      inst_incrementor = 1
      parts = inst.split(' ')
      if parts[1].match(/\d+/)
        parts[1] = parts[1].to_i
      end
      if parts[2].match(/\d+/)
        parts[2] = parts[2].to_i
      end
      case parts[0]
      when 'set'
        set(parts[1], parts[2])
      when 'sub'
        sub(parts[1], parts[2])
      when 'mul'
        mul(parts[1], parts[2])
      when 'jnz'
        inst_incrementor = jnz(parts[1], parts[2])
      end
      @instruction_pointer += inst_incrementor
    end
  end
end

instructions = []
File.open('./input') do |file|
  file.each_line do |line|
    instructions.push(line.chomp)
  end
end

hcf = Coprocessor.new(instructions)

hcf.run

puts "#{hcf.mulcount} multiplications at end of program"
