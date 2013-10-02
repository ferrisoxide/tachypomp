require 'eeepub'
require 'yaml'

usage       'build'
summary     'build epub and hpub packages from /output folder '
description 'This is a rough and ready post-compile tool to build epub and hpub files from content.'

flag   :h, :help,  'show help for this command' do |value, cmd|
  puts cmd.help
  exit 0
end

run do |opts, args, cmd|
  ROOT = File.join(File.dirname(__FILE__), '..')
  
  nanoc_config = YAML.load(File.read(File.join(ROOT, 'nanoc.yaml')))
  ebook_config = YAML.load(File.read(File.join(ROOT, 'ebook.yaml')))
  book_contents = JSON.load(File.read(File.join(nanoc_config['output_dir'], 'book.json')))
  
  puts "Building ePub"
  EPubBuilder::build(nanoc_config, ebook_config, book_contents)
  puts "Building hPub"  
  HPubBuilder::build(nanoc_config, ebook_config, book_contents)
  
end

class EPubBuilder
  def self.build(nanoc_config, ebook_config, book_contents)
    
    epub_dir = File.join(nanoc_config['output_dir'], 'epub')

    epub = EeePub.make do
      title       ebook_config['meta']['title']
      creator     ebook_config['meta']['creator'] # SMELL need to check epub spec
      publisher   ebook_config['meta']['publisher']
      date        ebook_config['meta']['date']
      identifier  ebook_config['epub']['identifier']['url'], 
                    :scheme => 'URL', 
                    :id => ebook_config['epub']['identifier']['id']  
      uid         ebook_config['epub']['uid']

      file_list = []
      nav_list = []

      book_contents['contents'].each do |file|
        file_name = "#{file}.xhtml"
        file_list << File.join(epub_dir, file_name)
        nav_list << {:label => file, :content => File.basename(file_name) }  
      end  

      files file_list 
      nav nav_list
    end

    FileUtils.mkdir_p(File.join(ROOT, 'output', 'epub', 'book'))
    epub_filename = File.join(ROOT, 'output', 'epub', 'book', 'tachypomp.epub')
    epub.save(epub_filename)
  #  FileUtils.rm_rf(epub_dir) # remove epub XHTML files created by nanoc

    puts "epub saved to #{epub_filename}"
  end      
end  

class HPubBuilder
  
  def self.build(nanoc_config, ebook_config, book_contents)  
    hpub_dir = File.join(nanoc_config['output_dir'], 'hpub')
  
    book = {
      :hpub       => ebook_config['hpub']['version'],
      :title      => ebook_config['meta']['title'],
      :author     => [ebook_config['meta']['creator']], # SMELL need to check epub spec
      :creator    => [ebook_config['meta']['publisher']], # SMELL need to check hpub spec
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
    puts "hPub saved to /#{hpub_dir}"
  end  
end  