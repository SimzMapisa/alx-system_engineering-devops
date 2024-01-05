#!/usr/bin/env ruby
input = ARGV[0]
matches = input.scan(/hbt{2,5}n/)
if matches
  puts matches.join
else
  puts "No match founf"
end
