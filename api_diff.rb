#!/usr/bin/env ruby

abort "usage: #{$PROGRAM_NAME} ref1 ref2" unless ARGV.length == 2

(ref1, ref2) = ARGV[0..2]

Dir.chdir("mruby")

diff = `git diff #{ref1}...#{ref2}`

file = ""
diff.lines.map(&:chomp).each do |line|
  if line.match(/\+\+\+ b\/(.*)/)
    file = $1
  elsif line.match(/[+-]MRB_API/)
    next if file.match?(/\.c$/)
    puts "#{file}: #{line}"
  end
end
