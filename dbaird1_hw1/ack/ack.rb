#! /usr/bin/env ruby
def ack(m,n)
  puts n
  if(m == 0)
      return n+1;
  end
  if(n == 0 && m > 0)
      return ack(m-1, 1);
  end
  if(n>0 && m > 0)
      return ack(m-1,ack(m, n-1));
  end
  return 0;
end



if ARGV.length != 1
  puts "fact.rb usage: [NUMBER]"
  exit
end

ack(3,ARGV[0].to_i);
