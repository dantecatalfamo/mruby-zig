#!/usr/bin/env ruby

require 'optparse'

abort "usage: #{$PROGRAM_NAME} ref1 ref2 [options]" unless ARGV.length >= 2

(ref1, ref2) = ARGV[0..2]
org_output = nil

OptionParser.new do |opts|
  opts.banner = "usage: #{$PROGRAM_NAME} ref1 ref2 [options]"

  opts.on('-o', '--org', 'Output in org format') do
    org_output = true
  end
end.parse!

Dir.chdir('mruby')

diff = `git diff #{ref1}...#{ref2}`

change_dict = {}
file_name = ''
diff.lines.map(&:chomp).each do |line|
  if line.match(%r{\+\+\+ b/(.*)})
    file_name = Regexp.last_match(1)
  elsif line.match(/[+-]MRB_API/)
    next if file_name.match?(/\.c$/)

    puts "#{file_name}: #{line}" unless org_output

    func_match = line.match(/(\w+)\(/)
    next unless func_match

    func_name = func_match[1]

    change_dict[file_name] ||= {}
    change_dict[file_name][func_name] ||= []
    change_dict[file_name][func_name] << line
  end
end

exit unless org_output

change_dict.each_pair do |f_name, file|
  puts "* TODO #{f_name} [0/#{file.length}]"
  file.each_pair do |func_name, func|
    puts "** TODO #{func_name}"
    puts '   #+begin_src c'
    func.each do |func_line|
      puts "   #{func_line}"
    end
    puts '   #+end_src'
    puts ''
  end
end
