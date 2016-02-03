#! /usr/bin/env ruby
def powF(n, p)
  if(p == 0)
    return 1
  end

  return n * powF(n, p-1)
end

def powI(n, p)
  if(p == 0)
    return 1
  end

  s = 1
  while p > 0 do
    p = p-1
    s=s*n
  end
  return s
end

if ARGV.length != 2
  puts "fact.rb usage: [NUMBER] [POWER]" 
  exit
end

puts powF(ARGV[0].to_i, ARGV[1].to_i)
puts powI(ARGV[0].to_i, ARGV[1].to_i)
