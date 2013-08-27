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
  
end  