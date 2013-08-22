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
  
  book = {:contents => []}
  
  source_filename = opts[:filename]  
  Breakdown::process(source_filename, './content') do |section|
    # Build index for consumption by epub and hpub builders
    book[:contents] << section[:title]
    
    # Use first markdown header (or first full line) as displayed title  
    # TODO should check to see if text already contains meta data
    title = ''
    # 
    section[:text].each_line do |line|
      title = line.match(/^(#\s)*(?<header_text>.*)/)[:header_text]
      title.strip!
      break if !title.empty?
    end  
    
    # Build meta data
    nanoc_metadata =  "---\n"
    nanoc_metadata += "title: \"#{title}\"\n" 
    nanoc_metadata += "---\n"
    
    section[:text] = nanoc_metadata + section[:text] 
  end  
  
  # Build eBook data, based on hPub format
  output_filename = './content/book.json'
  File.open(output_filename, 'w') { |file| file.write book.to_json }
  
end


# {
#   "title": "The Study in Scarlet",
#   "author": "Arthur Conan Doyle",
#   "url": "book://bakerframework.com/books/arthurconandoyle-thestudyinscarlet",
# 
#   "contents": [
#     "Article-Lorem.html",
#     "Article-Ipsum.html",
#     "Article-Gaium.html",
#     "Article-Sit.html",
#     "Article-Amet.html"
#   ]
# }
