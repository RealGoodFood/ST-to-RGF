source 'http://rubygems.org'

#ruby '1.9.3'

gem 'rails', '3.0.19'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# gem 'sqlite3-ruby', :require => 'sqlite3'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

# Bundle the extra gems:

# gem 'heroku' install the Heroku toolbelt (https://toolbelt.heroku.com/) instead (as gem had some problems)
#gem 'thin'
gem 'unicorn'

#for migrating database on heroku
gem 'taps'

gem 'haml'
gem 'sass'
gem 'database_cleaner'
gem 'rest-client', '>= 1.6.0'
gem 'httpclient' # Used by avatar upload
gem 'acts-as-taggable-on'
gem 'paperclip'
gem 'aws-sdk'
gem "will_paginate"
gem 'whenever'
gem 'newrelic_rpm'
gem 'memcache-client', ">= 1.8.5"
gem 'thinking-sphinx', :require => 'thinking_sphinx'
gem 'flying-sphinx'
gem 'recaptcha'
gem "airbrake"
gem 'passenger'
gem 'delayed_job'
gem 'delayed_job_active_record', '0.4.1'
gem 'json'
gem 'russian'
gem 'web_translate_it'
gem 'postmark-rails'
gem 'rails-i18n'
gem 'devise', '2.0.0.rc'
gem "omniauth"
gem "omniauth-facebook"
gem "omniauth-twitter"
gem 'omniauth-google-oauth2'
gem 'omniauth-linkedin'
gem 'spreadsheet'
gem 'rabl'
#gem 'rocket_pants'
gem 'rake', '0.8.7' # downgraded because issues with 0.9
gem 'daemons'
gem 'geocoder'
#gem 'cloudfiles', '1.4.15'
#gem "cloudfiles", :git => "git://github.com/rackspace/ruby-cloudfiles.git"
#gem 'paperclip-cloudfiles', '2.3.8.3', :require => 'paperclip'
gem "aws-s3", :require => "aws/s3"
gem "aws-sdk"
gem 'geocoder'  
gem "whenever", :require => false



group :production do
  gem 'pg'
  gem 'thin'
end

group :development do
  # gem "mysql2", "~> 0.2.7" #this version for Rails < 3.1 compatibility
  gem 'pg'
end

group :test do
  gem "rspec-rails"
  gem 'capybara'
  gem 'cucumber-rails', :require => false
  gem 'cucumber' 
  gem 'selenium-webdriver'
  gem 'launchy'
  gem 'ruby-prof'
  gem 'factory_girl_rails', '~> 1.7 '
  gem "pickle"
end

