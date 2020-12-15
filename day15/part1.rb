class MemoryGame
  def initialize(start)
    @last_word = start[-1]
    @round = start.length + 1
    @table = Hash.new
    start[0..-2].each_with_index {|w, i| @table[w] = i + 1}
  end

  def play(num_rounds=30000000)
    while @round <= num_rounds do
      if @table.has_key?(@last_word)
        word = @round - 1 - @table[@last_word]
      else
        word = 0
      end
      @table[@last_word] = @round - 1
      @last_word = word
      @round += 1
    end
    @last_word
  end
end

p MemoryGame.new([0,3,6]).play
p MemoryGame.new([1,3,2]).play
p MemoryGame.new([2,1,3]).play
p MemoryGame.new([1,2,3]).play
p MemoryGame.new([2,3,1]).play
p MemoryGame.new([3,2,1]).play
p MemoryGame.new([3,1,2]).play
p MemoryGame.new([11,18,0,20,1,7,16]).play
