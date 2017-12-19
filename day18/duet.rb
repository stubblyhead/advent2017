class Duet
  attr_reader :registers, :lastsound, :instructions

  def initialize(instructions)
    @registers = Hash.new(0)
    @instructions = instructions
    @instruction_pointer = 0
    @recovered = false
  end
  def snd(freq)
    @lastsound = freq
  end
  def set(register, value)
    if value.class == 'Integer'
      registers[register] = value
    else
      regirsters[register] = registers[value]
    end
  end

  def add(register, value)
    if value.class == 'Integer'
      registers[register] += value
    else
      registers[register] += registers[value]
    end
  end

  def mul(register, value)
    if value.class == 'Integer'
      registers[register] *= value
    else
      registers[register] *= registers[value]
    end
  end

  def mod(register, value)
    if value.class == 'Integer'
      registers[register] %= value
    else
      registers[register] %= registers[value]
    end
  end

  def rcv(value)
    if value.class == 'Integer'
      return @lastsound if value
      @recovered = true
    else
      return @lastsound if registers[value]
      @recovered = true
    end
  end

  def jgz(value, offset)
    value = registers[value] unless value.class == 'Integer'
    if value > 0
      return offset
    else
      return 1
    end
  end

  def play
    until @recovered
      inst = instructions[instruction_pointer]
      inst_incrementor = 1
      parts = inst.split(' ')
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
      instruction_pointer += inst_incrementor
    end
  end
end
