class Ticket
  def initialize(input)
    @values = input.split(',').map {|i| i.to_i}
  end

  def invalid_values(rules)
    @values.select do |value|
      rules.all? {|r| !r.valid?(value)}
    end
  end
end

class Rule
  def initialize(input)
    match = /^([a-z ]+): (\d+)-(\d+) or (\d+)-(\d+)$/.match(input)
    @name = match[1]
    @ranges = [match[2].to_i..match[3].to_i, match[4].to_i..match[5].to_i]
  end

  def valid?(value)
    @ranges.any? {|r| r.include?(value)}
  end
end

class TicketScanner
  def initialize(file)
    inputs = File.readlines(file, chomp: true).slice_after(/$^/).to_a
    @rules = inputs[0][0..-2].map {|i| Rule.new(i)}
    @my_ticket = Ticket.new(inputs[1][1])
    @nearby_tickets = inputs[2][1..-1].map {|i| Ticket.new(i)}
  end

  def error_rate
    @nearby_tickets.map {|t| t.invalid_values(@rules)}.flatten.sum
  end
end

p TicketScanner.new("#{__dir__}/example.txt").error_rate
p TicketScanner.new("#{__dir__}/input.txt").error_rate
