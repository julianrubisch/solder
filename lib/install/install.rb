if Rails.root.join("config/importmap.rb").exist?
  say "Pin @rails/request.js"
  append_to_file "config/importmap.rb", %(pin "@rails/request.js", preload: true\n)
else
  say "Install @rails/request.js"
  run "yarn add @rails/request.js"
end

# if stimulus isn't present
# bundle add stimulus-rails
# bin/rails stimulus:install
gemfile = Rails.root.join("Gemfile").read
binding.irb

say "Installing Stimulus"
gem "stimulus-rails"
rails_command "stimulus:install"
