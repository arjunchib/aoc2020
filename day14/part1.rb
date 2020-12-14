class SeaPortComputer
  def initialize(file)
    @mem = Array.new
    @program = Array.new
    @mask0 = -1
    @mask1 = 0
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
    @mask0 = mask.gsub('X', '1').to_i(2)
    @mask1 = mask.gsub('X', '0').to_i(2)
  end

  def mem(addy, value)
    @mem[addy] = value & @mask0 | @mask1
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
    @mem.compact.sum
  end
end

comp = SeaPortComputer.new("#{__dir__}/example.txt")
comp.run
p comp.sum

comp = SeaPortComputer.new("#{__dir__}/input.txt")
comp.run
p comp.sum
