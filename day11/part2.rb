class SeatChart
  def initialize(file)
    @chart = File.readlines(file).map {|line| line.strip.chars}
  end

  def print
    @chart.each {|row| puts row.join('')}
  end

  def fill
    rows = (0...@chart.length).to_a
    cols = (0...@chart[0].length).to_a
    indecies = rows.product(cols)
    loop do
      new_chart = Array.new(@chart.length) {Array.new}
      indecies.each {|i, j| new_chart[i][j] = update_seat(i,j)}
      if new_chart == @chart
        break
      else
        @chart = new_chart
      end
    end
  end

  def seat_in_bounds?(row, col)
    (row >= 0 &&
    col >= 0 &&
    row < @chart.length &&
    col < @chart[0].length)
  end

  def visible_seat(row, col, delta_x, delta_y)
    i = row
    j = col
    seat = "."
    while seat == "." do
      i += delta_x
      j += delta_y
      break if !seat_in_bounds?(i, j)
      seat = @chart[i][j]
    end
    seat
  end

  def adjacencies(row,col)
    range = (-1..1).to_a
    indecies = range.product(range)
    indecies.delete([0,0])
    indecies.map {|i, j| visible_seat(row, col, i, j)}
  end

  def update_seat(row, col)
    seat = @chart[row][col]
    case seat
    when 'L'
      adjacencies(row, col).count('#') == 0 ? '#' : 'L'
    when '#'
      adjacencies(row, col).count('#') >= 5 ? 'L' : '#'
    when '.'
      '.'
    end
  end

  def count_occupied_seats
    @chart.flatten.count('#')
  end
end

example = SeatChart.new("#{__dir__}/example.txt")
example.fill
example.print
p example.count_occupied_seats

input = SeatChart.new("#{__dir__}/input.txt")
input.fill
p input.count_occupied_seats
