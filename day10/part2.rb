class AdapterAnalyzer
  def initialize(file)
    @buffer = File.readlines(file).map {|line| line.to_i}.sort
    @buffer.insert(0, 0)
    @buffer.push(@buffer.last + 3)
    @max = 0
  end

  def analyze
    @buffer.each_cons(2).map {|a,b| b - a}
  end

  def count_arrangements
    partitions = analyze.slice_before {|i| i == 3}.to_a
    partitions.each {|arr| arr.delete(3)}
    partitions.delete_if {|arr| arr.length == 0}
    counts = partitions.map {|arr| arr.length}
    counts = counts.map do |count|
      case count
      when 1
        1
      when 2
        2
      when 3
        4
      when 4
        7
      end
    end
    counts.reduce(:*)
  end
end

p AdapterAnalyzer.new("#{__dir__}/example_easy.txt").count_arrangements
p AdapterAnalyzer.new("#{__dir__}/example.txt").count_arrangements
p AdapterAnalyzer.new("#{__dir__}/input.txt").count_arrangements
