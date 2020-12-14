class BusScheduler
  def initialize(file)
    lines = File.readlines(file)
    @etd = lines[0].to_i
    @buses = lines[1].split(',')
      .reject {|i| i == 'x'}
      .map {|i| i.to_i}
  end

  def wait_time(bus)
    bus - (@etd % bus)
  end

  def shortest_wait
    @buses.min {|a, b| wait_time(a) <=> wait_time(b)}
  end

  def process
    bus = shortest_wait
    bus * wait_time(bus)
  end
end

p BusScheduler.new("#{__dir__}/example.txt").process
p BusScheduler.new("#{__dir__}/input.txt").process

