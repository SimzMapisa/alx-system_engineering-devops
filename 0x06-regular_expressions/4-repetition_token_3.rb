#!/usr/bin/env ruby
input = ARGV[0]
matches = input.scan(/hbt*n/)
if matches
  puts matches.join
else
  puts "No match found"
end
