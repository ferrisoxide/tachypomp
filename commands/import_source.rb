require 'breakdown'
require 'json'

usage       'import_source [options]'
aliases     :is, :import
summary     'imports source file'
description 'TODO enter description here'

flag   :h, :help,  'Help' do |value, cmd|
  puts cmd.help
  exit 0
end

option :f, :filename, 'specify path to source file', :argument => :required

run do |opts, args, cmd|
  
  
  
  filename = opts[:filename]  
  Breakdown::process(filename, './content') do |section|
    # Build index for consumption by epub and hpub builders
    
    section  
  end  
end