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
  ebook_config = YAML.load(File.read(File.join(ROOT, 'ebook.yaml')))
  book_contents = JSON.load(File.read(File.join(nanoc_config['output_dir'], 'book.json')))
  
  meta_data = ebook_config['meta']
  
  epub_dir = File.join(nanoc_config['output_dir'], 'epub')
    
  epub = EeePub.make do
    title       meta_data['title']
    creator     meta_data['creator']
    publisher   meta_data['publisher']
    date        meta_data['date']
    identifier  meta_data['identifier']['url'], :scheme => 'URL', :id => meta_data['identifier']['id']  
    uid         meta_data['uid']
    
    file_list = []
    nav_list = []
    
    puts '++++'

    
    book_contents['contents'].each do |file|
      file_name = "#{file}.xhtml"
      file_list << File.join(epub_dir, file_name)
      nav_list << {:label => file, :content => File.basename(file_name) }  
    end  
      
      
    
    # chapters = OUTLINE.keys.sort
    # chapters.each do |chapter| 
    #   nav_pages = []
    #   
    #   pages = OUTLINE[chapter].keys.sort
    #   nav_pages = pages.each.collect do |page| 
    #     page =  OUTLINE[chapter][page] 
    #     
    #     file = File.join(epub_dir, page[:file])
    #     file_list << file
    #     {:label => "#{page[:label]}", :content => File.basename(file) }  
    #   end  
    #   
    #   nav_list << nav_pages
    # end
    
    files file_list 
    nav nav_list
  end
  
  FileUtils.mkdir_p(File.join(ROOT, 'output', 'epub', 'book'))
  epub_filename = File.join(ROOT, 'output', 'epub', 'book', 'tachypomp.epub')
  epub.save(epub_filename)
#  FileUtils.rm_rf(epub_dir) # remove epub XHTML files created by nanoc
  
  puts "epub saved to #{epub_filename}"
end