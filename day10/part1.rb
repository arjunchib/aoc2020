class AdapterAnalyzer
  def initialize(file)
    @buffer = File.readlines(file).map {|line| line.to_i}.sort
    @buffer.insert(0, 0)
    @buffer.push(@buffer.last + 3)
  end

  def analyze
    diffs = @buffer.each_cons(2).map {|a,b| b - a}
    p diffs
    diffs.count(1) * diffs.count(3)
  end
end

p AdapterAnalyzer.new("#{__dir__}/example.txt").analyze
p AdapterAnalyzer.new("#{__dir__}/input.txt").analyze
