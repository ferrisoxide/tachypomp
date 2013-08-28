require 'breakdown'
require 'yaml'
require 'json'

usage       'import'
summary     'import source file'
description 'Import source file specified in ebook.yaml'

flag   :h, :help,  'Help' do |value, cmd|
  puts cmd.help
  exit 0
end

run do |opts, args, cmd|
  # Load configuration
  ROOT = File.join(File.dirname(__FILE__), '..')
  ebook_config = YAML.load(File.read(File.join(ROOT, 'ebook.yaml')))
  source_filename = ebook_config['source']
  
  raise "Missing :source configuration in ebook.yaml" if source_filename.empty?
  raise "Source file #{source_filename}" unless File.exists?(source_filename)
  
  puts "Importing source: #{source_filename}"
  
  book = {:contents => []}
      
  Breakdown::process(source_filename, './content') do |section|
    puts "\t.. Creating section: ./content/#{section[:title]}.md"
    
    # Build index for consumption by epub and hpub builders
    book[:contents] << section[:title]
    
    # Use first markdown header (or first full line) as displayed title  
    # TODO should check to see if text already contains meta data
    title = ''
    
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
  puts "\t.. Creating book contents: #{output_filename}"
  File.open(output_filename, 'w') { |file| file.write JSON.pretty_generate(book) }
  
  puts "Done."
end