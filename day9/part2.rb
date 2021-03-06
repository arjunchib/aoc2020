class XmasDecoder
  def initialize(file, n=25)
    @n = n
    @buffer = File.readlines(file).map {|line| line.to_i}
  end

  def subsetSum2?(set, target)
    set.combination(2).map {|subset| subset.sum}.include?(target)
  end

  def find_first_invalid
    i = @n
    while i < @buffer.length
      break if !subsetSum2?(@buffer[(i - @n)...i], @buffer[i])
      i += 1
    end
    @buffer[i]
  end

  def crack
    invalid = find_first_invalid()
    i = 0
    j = 1
    while i < @buffer.length
      sum = @buffer[i..j].sum
      if (sum == invalid)
        break
      elsif (sum < invalid)
        j += 1
      elsif (sum > invalid)
        i += 1
        j = i + 1
      end
    end
    @buffer[i..j].min + @buffer[i..j].max
  end

end

p XmasDecoder.new("#{__dir__}/example.txt", 5).crack
p XmasDecoder.new("#{__dir__}/input.txt", 25).crack
