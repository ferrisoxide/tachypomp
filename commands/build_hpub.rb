require 'yaml'

usage       'build_hpub'
summary     'build hpub file from output/hpub'
description 'This is a rough and ready post-compile tool to build hpub files from content.'

flag   :h, :help,  'show help for this command' do |value, cmd|
  puts cmd.help
  exit 0
end

run do |opts, args, cmd|
  ROOT = File.join(File.dirname(__FILE__), '..')
  
  nanoc_config = YAML.load(File.read(File.join(ROOT, 'nanoc.yaml')))
  ebook_config = YAML.load(File.read(File.join(ROOT, 'ebook.yaml')))
  book_contents = JSON.load(File.read(File.join(nanoc_config['output_dir'], 'book.json')))
  
  meta_data = ebook_config['meta']
  
  hpub_dir = File.join(nanoc_config['output_dir'], 'hpub')
  
  book = {
    :hpub       => ebook_config['hpub']['version'],
    :title      => ebook_config['meta']['title'],
    :author     => [ebook_config['meta']['creator']], # SMELL need to check epub spec
    :creator  => [ebook_config['meta']['publisher']], # SMELL need to check hpub spec
    :date       => ebook_config['meta']['date'],
    :url        => ebook_config['hpub']['url'] 
  }
  
  # SMELL convert to map
  file_list = []
  book_contents['contents'].each do |file|
    file_list << "#{file}.html"
  end
  
  book[:contents] = file_list
  
  
  # Build eBook data, based on hPub format
  output_filename = File.join(hpub_dir, 'book.json')
  File.open(output_filename, 'w') { |file| file.write JSON.pretty_generate(book) }
  
end

  