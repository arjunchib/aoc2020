class BusScheduler
  def initialize(lines)
    @buses = lines.split(',').map {|i| i.to_i}
  end

  def lcm_offset(a, b, offset)
    r = b % a
    q = 1
    until q * r % b == offset do
      q += 1
    end
    return q
  end

  def process
    acc = Array.new(@buses.length) {Array.new}
    @buses.each_with_index.reject {|bus, index| bus == 0}.combination(2).each do |a, b|
      p a, b
      acc[a[1]].push(lcm_offset(a[0], b[0], b[1] - a[1]))
    end
    p acc
  end
end

input = '13,x,x,41,x,x,x,37,x,x,x,x,x,659,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,19,x,x,x,23,x,x,x,x,x,29,x,409,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,17'

p BusScheduler.new('7,13,x,x,59,x,31,19').process
# p BusScheduler.new('17,x,13,19').process
# p BusScheduler.new('67,7,59,61').process
# p BusScheduler.new('67,x,7,59,61').process
# p BusScheduler.new('67,7,x,59,61').process
# p BusScheduler.new('1789,37,47,1889').process
# p BusScheduler.new(input).process

