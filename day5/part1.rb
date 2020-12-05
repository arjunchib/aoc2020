class BoardingPass
  attr_reader :seat

  NUM_ROWS = 128
  NUM_COLS = 8

  def initialize(partitioning)
    row_str = partitioning[0...7].gsub('F','0').gsub('B','1')
    col_str = partitioning[7..-1].gsub('L','0').gsub('R','1')
    @row = get_index(row_str)
    @col = get_index(col_str)
    @seat = get_seat_id(@row, @col)
  end

  def get_index(part_str)
    part_str.to_i(2)
  end

  def get_seat_id(row,col)
    row * NUM_COLS + col
  end
end

# example
lines = File.readlines("#{__dir__}/example.txt")
lines.each do |line|
  p BoardingPass.new(line).seat
end

# part1
lines = File.readlines("#{__dir__}/input.txt")
p lines.map {|line| BoardingPass.new(line).seat}.max

# part2
lines = File.readlines("#{__dir__}/input.txt")
seats = lines.map {|line| BoardingPass.new(line).seat}.sort
seats.each_cons(2) {|a,b| p a + 1 if (a + 2 == b)}

