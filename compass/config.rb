http_path    = '/'
project_path = '.'
css_dir      = 'content/assets/stylesheets'
sass_dir     = 'content/assets/stylesheets'
images_dir   = 'content/assets/images'
relative_assets = true

# when using SCSS:
sass_options = {
  syntax: :scss
}

if ENV['NANOC_ENV'] == 'production'
  output_style = :compressed
end
