require 'eeepub'
require 'yaml'

usage       'build_epub'
summary     'build epub file from output/epub'
description 'This is a rough and ready post-compile tool to build epub files from content.'

flag   :h, :help,  'show help for this command' do |value, cmd|
  puts cmd.help
  exit 0
end

run do |opts, args, cmd|
  ROOT = File.join(File.dirname(__FILE__), '..')
  
  nanoc_config = YAML.load(File.read(File.join(ROOT, 'nanoc.yaml')))
  epub_config = YAML.load(File.read(File.join(ROOT, 'epub.yaml')))
  
  META = epub_config['meta']
  
  
  epub_dir = File.join(nanoc_config['output_dir'], 'epub')
    
  epub = EeePub.make do
    title       META['title']
    creator     META['creator']
    publisher   META['publisher']
    date        META['date']
    identifier  META['identifier']['url'], :scheme => 'URL', :id => META['identifier']['id']  
    uid         META['uid']

    OUTLINE = YAML.load(File.read(File.join(ROOT, 'tmp', 'outline.yaml')))
    
    file_list = []
    nav_list = []
    
    chapters = OUTLINE.keys.sort
    chapters.each do |chapter| 
      nav_pages = []
      
      pages = OUTLINE[chapter].keys.sort
      nav_pages = pages.each.collect do |page| 
        page =  OUTLINE[chapter][page] 
        
        file = File.join(epub_dir, page[:file])
        file_list << file
        {:label => "#{page[:label]}", :content => File.basename(file) }  
      end  
      
      nav_list << nav_pages
    end
    
    files file_list 
    nav nav_list
  end
  
  FileUtils.mkdir_p(File.join(ROOT, 'output', 'epub', 'book'))
  epub_filename = File.join(ROOT, 'output', 'epub', 'book', 'this-purple-world.epub')
  epub.save(epub_filename)
  #FileUtils.rm_rf(epub_dir) # remove epub XHTML files created by nanoc
  
  puts "epub saved to #{epub_filename}"
end