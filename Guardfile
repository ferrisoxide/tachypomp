# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'nanoc' do
  watch('nanoc.yaml') # Change this to config.yaml if you use the old config file name
  watch('Rules')
  watch(%r{^(content|layouts|lib)/.*$})
end


# A 'cheat' approach to getting nanoc to import on changes to source text file
# TODO replace with a more succinct mechanism once I understand the guard gem better
guard 'process', :name => 'ImportSource', :command => 'nanoc import' do
  ebook_config = YAML.load './ebook.yaml'
  watch(ebook_config['source'])
end
