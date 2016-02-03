#! /usr/bin/env ruby
def pow(n, p)
  if(p == 0)
    return 1
  end

  return n * pow(n, p-1)
end

if ARGV.length != 2
  puts "fact.rb usage: [NUMBER] [POWER]" 
  exit
end

puts pow(ARGV[0].to_i, ARGV[1].to_i)
