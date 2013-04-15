# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

module TableOfContents
  def render_toc
    toc_item = @items.find { |i| i.identifier == '/toc/' }
    toc_lines = toc_item.raw_content.lines 
    result = '<ul>'
    section_count = 0
    toc_lines.each do |line|
      section_count += 1
      result += "<li><a href='/section-#{section_count}'>#{line}</a></li>"
    end  
    result += '</ul>'
    result    
  end  
end  

include TableOfContents