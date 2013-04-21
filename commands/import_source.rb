require 'breakdown'

usage       'import_source [options]'
aliases     :is, :import
summary     'imports source file'
description 'TODO enter description here'

flag   :h, :help,  'Help' do |value, cmd|
  puts cmd.help
  exit 0
end
#flag   :m, :more,  'do even more stuff'
option :f, :filename, 'specify path to source file', :argument => :required

run do |opts, args, cmd|
  
  filename = opts[:filename]  
  Breakdown::process(filename, './content')

end