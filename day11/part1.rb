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

  def adjacencies(row,col)
    seats = []
    rows = ((row - 1)..(row + 1)).to_a
    cols = ((col - 1)..(col + 1)).to_a
    indecies = rows.product(cols)
    indecies.delete_if do |i, j|
      i < 0 ||
      j < 0 ||
      i >= @chart.length ||
      j >= @chart[0].length ||
      (i == row && j == col)
    end
    indecies.map {|i, j| @chart[i][j]}
  end

  def update_seat(row, col)
    seat = @chart[row][col]
    case seat
    when 'L'
      adjacencies(row, col).count('#') == 0 ? '#' : 'L'
    when '#'
      adjacencies(row, col).count('#') >= 4 ? 'L' : '#'
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
