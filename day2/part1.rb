def process(file)
  lines = File.readlines(file)
  lines.map {|line| validate(line) ? 1 : 0}.sum
end

def validate(line)
  policy,password = line.split(': ')
  range,term = policy.split(' ')
  lower,upper = range.split('-').map {|a| a.to_i}
  count = password.count(term)
  lower <= count and count <= upper
end

if __FILE__ == $0
  # puts process('example.txt')
  puts process('passwords.txt')
end
