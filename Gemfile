source 'http://rubygems.org'

gem 'rails', '3.1.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'pg'

# view gems
gem 'haml'

# application gems
gem 'devise' # user management
gem 'youtube_it'  # youtube integration


##
# redis
#
# hiredis is a high performance redis driver that supports timeouts on a socket
gem "hiredis", "~> 0.3.1"
gem "redis", "~> 2.2.0", :require => ["redis/connection/hiredis", "redis"]

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

# for assets compilation
group :assets do
  gem 'therubyracer'
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

group :development, :test do
  # Pretty printed test output
  gem 'turn', '0.8.2', :require => false
  gem 'ZenTest', '~> 4.6.1' # autotest lives here
  gem 'spork', '~> 0.9.0.rc'
  gem 'rspec-rails', '~> 2.6.0'
  gem 'shoulda'
  gem 'rr'
  gem 'machinist', '~>1.0.6'
  gem 'faker'
  gem 'pry'
  gem 'gist'
  gem 'timecop' # Testing time sensitive behavior
end
