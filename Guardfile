# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'nanoc' do
  watch('nanoc.yaml') # Change this to config.yaml if you use the old config file name
  watch('Rules')
  watch(%r{^(content|layouts|lib)/.*$})
end

# A 'cheat' approach to getting nanoc to import on changes to source text file
# TODO replace with a more succinct mechanism once I understand the guard gem better
guard 'process', :name => 'ImportSource', :command => 'nanoc import --filename the-tachypomp-and-other-stories.md' do
  watch('the-tachypomp-and-other-stories.md')
end
