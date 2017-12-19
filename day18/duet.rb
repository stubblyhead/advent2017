class Duet
  attr_reader :registers, :lastsound, :instructions

  def initialize(instructions)
    @registers = Hash.new(0)
    @instructions = instructions
    @instruction_pointer = 0
    @recovered = false
  end
  def snd(value)
    if value.class.to_s == 'Fixnum'
      @lastsound = value
    else
      @lastsound = registers[value]
    end
  end
  def set(register, value)
    if value.class.to_s == 'Fixnum'
      registers[register] = value
    else
      registers[register] = registers[value]
    end
  end

  def add(register, value)
    if value.class.to_s == 'Fixnum'
      registers[register] += value
    else
      registers[register] += registers[value]
    end
  end

  def mul(register, value)
    if value.class.to_s == 'Fixnum'
      registers[register] *= value
    else
      registers[register] *= registers[value]
    end
  end

  def mod(register, value)
    if value.class.to_s == 'Fixnum'
      registers[register] %= value
    else
      registers[register] %= registers[value]
    end
  end

  def rcv(value)
    if value.class.to_s == 'Fixnum'
      if value > 0
        @recovered = true
        return @lastsound
      end

    else
      if registers[value] > 0
        @recovered = true
        return @lastsound
      end
    end
  end

  def jgz(value, offset)
    value = registers[value] unless value.class.to_s == 'Fixnum'
    if value > 0
      return offset
    else
      return 1
    end
  end

  def play
    until @recovered
      inst = @instructions[@instruction_pointer]
      inst_incrementor = 1
      parts = inst.split(' ')
      if parts[1].match(/\d+/)
        parts[1] = parts[1].to_i
      end
      if parts[2] && parts[2].match(/\d+/)
        parts[2] = parts[2].to_i
      end
      case parts[0]
      when 'snd'
        snd(parts[1])
      when 'set'
        set(parts[1], parts[2])
      when 'add'
        add(parts[1], parts[2])
      when 'mul'
        mul(parts[1], parts[2])
      when 'mod'
        mod(parts[1], parts[2])
      when 'rcv'
        rcv(parts[1])
      when 'jgz'
        inst_incrementor = jgz(parts[1], parts[2])
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

duet = Duet.new(instructions)
duet.play
puts duet.lastsound
