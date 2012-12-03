source 'http://rubygems.org'

gem 'rails', '3.1.0'   #pre 3.1.0

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'

group :development do
  gem 'ruby-debug19', :require => 'ruby-debug'
end

gem 'make_flaggable', :git => 'git://github.com/cavneb/make_flaggable.git'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   "~> 3.1.0"  #pre 3.1.0
  gem 'coffee-rails', "~> 3.1.0"  #pre 3.1.0
  gem 'uglifier' # ,  '>=1.0.3'  #pre none
end

gem 'jquery-rails'
# background
gem 'delayed_job_active_record'
gem 'daemons'
#  facebook
gem 'omniauth-facebook'
#  in-place edit
gem 'best_in_place'
#  image upload
gem 'carrierwave'
gem 'rmagick'
# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem 'haml'
gem 'nokogiri'
gem 'xpath'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'minitest', "~> 4.3.0"
end
group :development, :test do
  gem 'ruby-debug19'
  gem 'rspec-expectations'
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'launchy'
end
