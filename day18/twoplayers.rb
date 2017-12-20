class Duet
  attr_reader :registers, :instructions, :queue, :values_sent, :waiting

  def initialize(instructions, id)
    @registers = Hash.new(0)
    @registers['p'] = id
    @instructions = instructions
    @instruction_pointer = 0
    @queue = []
    @values_sent = 0
  end
  def set_partner(partner)
    @partner = partner
  end

  def queue_add(value)
    @queue.push(value)
    # => puts "put value #{value} into queue"
  end

  def snd(value)
    if value.class.to_s == 'Fixnum'
      @partner.queue_add(value)
    else
      @partner.queue_add(@registers[value])
    end
    @values_sent += 1
  end
  def set(register, value)
    if value.class.to_s == 'Fixnum'
      registers[register] = value
      #puts "registers[#{register}] is now #{value}"
    else
      registers[register] = registers[value]
      #puts "registers[#{register}] is now #{registers[value]}"
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

  def rcv(register)
    if @queue.length > 0
      registers[register] = @queue[0]
      #puts "put value #{queue[0]} into registers[#{register}]"
      @queue = @queue[1..-1]
      return true
    else
      return false
    end
  end

  def jgz(value, offset)
    value = registers[value] unless value.class.to_s == 'Fixnum'
    offset = registers[offset] unless offset.class.to_s == 'Fixnum'
    if value > 0
      return offset
    else
      return 1
    end
  end

  def play
    @waiting = false
    until @waiting
      inst = @instructions[@instruction_pointer]
      inst_incrementor = 1
      #puts inst
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
        unless rcv(parts[1])
          @waiting = true
          inst_incrementor = 0
        end
      when 'jgz'
        inst_incrementor = jgz(parts[1], parts[2])
        #puts inst_incrementor
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

player_a = Duet.new(instructions, 0)
player_b = Duet.new(instructions, 1)

player_a.set_partner(player_b)
player_b.set_partner(player_a)

until player_a.waiting == true && player_b.waiting == true && player_a.queue.length == 0 && player_b.queue.length == 0
  #puts "player_a's turn"
  player_a.play
  #puts "player_b's turn"
  player_b.play
end

puts player_b.values_sent
