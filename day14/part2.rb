class SeaPortComputer
  def initialize(file)
    @mem = Hash.new
    @program = Array.new
    @masks = []
    @float_mask = 0
    @program = File.readlines(file).map do |line|
      ins = /^(.*?)(?:\[(.*)\])? = (.*)$/.match(line)[1..-1].compact
      op = ins[0].to_sym
      args = nil
      case op
      when :mask
        args = ins[1]
      when :mem
        addy = ins[1].to_i
        value = ins[2].to_i
        args = [addy, value]
      end
      { op: op, args: args }
    end
  end

  def mask(mask)
    base = mask.gsub('X', '0').to_i(2)
    floats = []
    mask.chars.reverse.each_with_index do |bit, index|
      if bit == 'X'
        floats.push(index)
      end
    end
    @masks = [base]
    @float_mask = 0
    floats.each do |index|
      @float_mask = @float_mask | (1 << index)
      @masks[0..-1].each do |m|
        @masks.push(m | (1 << index))
      end
    end
  end

  def mem(addy, value)
    @masks.each do |m|
      @mem[addy & ~@float_mask | m] = value
    end
  end

  def run
    @program.each do |ins|
      op, args = ins.values_at(:op, :args)
      case op
      when :mask
        mask(*args)
      when :mem
        mem(*args)
      end
    end
    @mem
  end

  def sum
    @mem.values.sum
  end
end

comp = SeaPortComputer.new("#{__dir__}/example2.txt")
comp.run
p comp.sum

comp = SeaPortComputer.new("#{__dir__}/input.txt")
comp.run
p comp.sum
