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
  
  class BookBuilder
    
    attr_accessor :section_count
    
    def initialize
      self.section_count = 0  
    end  
    
    def self.process(filename)
      dsl = new
      dsl.instance_eval(File.read(filename))
    end
      
    def discard(text)
      
    end
    
    def section(text)
      self.section_count += 1
      File.open("./content/section-#{self.section_count}.html", 'w') do |file|
        file.write(text)
      end   
      
      puts "Section count #{self.section_count}"
    end  
    
    def index(text)
      File.open('./content/index.html', 'w') do |file|
        file.write(text)
      end
    end 
    
    def toc(text)
      File.open('./content/toc.html', 'w') do |file|
        file.write(text)
      end      
    end  
  end
  
  filename = opts[:filename]
  BookBuilder.process(filename)
end