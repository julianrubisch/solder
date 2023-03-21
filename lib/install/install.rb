# install @rails/request.js
if Rails.root.join("config/importmap.rb").exist?
  say "Pin @rails/request.js"
  append_to_file "config/importmap.rb", %(pin "@rails/request.js", preload: true\n)
else
  say "Install @rails/request.js"
  run "yarn add @rails/request.js"
end

gemfile = Rails.root.join("Gemfile").read

# install stimulus-rails, if not already present
if !gemfile.include? "stimulus-rails"
  gem "stimulus-rails"
  rails_command "stimulus:install"
  say "✅ stimulus-rails has been installed"
else
  say "⏩ stimulus-rails is already installed. Skipping."
end

# copy stimulus controller template
generate "solder:stimulus"

# turn on development caching
if Rails.root.join("tmp", "caching-dev.txt").exist?
  say "⏩ Already caching in development. Skipping."
else
  system "rails dev:cache"
  say "✅ Enabled caching in development"
end

# mount engine
route 'mount Solder::Engine, at: "/solder"'

# copy initializer template
generate "solder:initializer" if yes?("Do you want to install the solder initializer template?")
