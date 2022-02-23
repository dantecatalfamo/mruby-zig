#!/usr/bin/env ruby
# frozen_string_literal: true

def new_param(param)
  pointer = param['*']
  param.sub!('*', '')
  param_parts = param.split(' ')
  type = ''
  name = param_parts.last
  # variadic
  return '...' if param_parts[0] == '...'

  if param_parts[0] == 'struct'
    # struct
    type = param_parts[1]
  elsif param_parts[0] == 'const' && param_parts[1] == 'char'
    # string
    type = '[*:0]const u8'
    pointer = nil
  elsif pointer && param_parts[0] == 'const'
    # array
    type = "[*]const #{param_parts[1]}"
    pointer = nil
  else
    # regular type
    type = param_parts[0]
  end

  "#{name}: #{pointer}#{type}"
end

def new_type(type)
  pointer = type['*']
  pointerless = type.sub('*', '')
  param_parts = pointerless.split(' ')
  type2 = if param_parts[0] == 'struct'
            param_parts[1]
          else
            param_parts[0]
          end
  "#{'?*' if pointer}#{type2}"
end

ARGF.each_line do |line|
  puts "/// #{line[3..].sub('*/', '')}" if line[0..2]['*'] # comment line
  next unless line.start_with?('MRB_API')

  line.sub!('MRB_API', '')
  line.sub!(';', '')
  return_type = line.match(/(.+?) mrb_/)[1].strip
  new_return_type = new_type(return_type)
  line.sub!(return_type, '').strip!
  func_split = line.split(/[()]/)
  func_name = func_split[0]
  params = func_split[1].split(',')
  new_params = params.map { |param| new_param(param) }

  puts "pub extern fn #{func_name}(#{new_params.join(', ')}) #{new_return_type};"
end
