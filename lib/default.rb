# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

module TableOfContents
  def render_toc
    toc_item = @items.find { |i| i.identifier == '/table-of-contents/' }
    toc_lines = toc_item.raw_content.lines 
    result = '<ul>'
    section_count = 0
    toc_lines.each do |line|
      unless line.empty? || (line == "\r\n") # SMELL Windows line feed
        section_count += 1
        result += "<li><a href='/section-#{section_count}/'>#{line}</a></li>"
      end  
    end  
    result += '</ul>'
    result    
  end  
end  

include TableOfContents


require 'nanoc/filters/javascript_concatenator'
require 'compass'
require 'zurb-foundation'
#require 'faker'

# NOTE: don't need all these - copied over from nanoc-blog template project
include Nanoc::Helpers::Blogging
include Nanoc::Helpers::Tagging
include Nanoc::Helpers::Rendering
include Nanoc::Helpers::LinkTo
include Nanoc::Helpers::XMLSitemap

unless defined? LOADED_DEFAULT_CONFIG
  LOADED_DEFAULT_CONFIG = true

  Compass.add_project_configuration 'compass/config.rb'
end
