def process(file)
  lines = File.readlines(file)
  lines.map {|line| validate(line) ? 1 : 0}.sum
end

def validate(line)
  policy,password = line.split(': ')
  range,term = policy.split(' ')
  pos1,pos2 = range.split('-').map {|a| a.to_i}
  [password[pos1 - 1], password[pos2 - 1]].count(term) == 1
end

if __FILE__ == $0
  # puts process('example.txt')
  puts process('passwords.txt')
end
