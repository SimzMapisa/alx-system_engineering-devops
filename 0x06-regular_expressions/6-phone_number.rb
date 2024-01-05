#!/usr/bin/env ruby
input = ARGV[0]
matches = input.scan(/^\d{10}$/)
if matches
  puts matches.join
else
  puts "No match found"
end
