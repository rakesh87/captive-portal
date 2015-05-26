source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.8'

group :assets do
  gem 'sass-rails',   '~> 4.0.3'
  gem 'coffee-rails', '~> 4.0.0'
  gem 'uglifier', '>= 1.0.3'
end

# front end
gem 'bootstrap-sass', '3.2.0.2'
gem 'autoprefixer-rails'
gem 'jquery-rails'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# authentication and authorization and role
gem 'devise'
gem 'cancancan', '~> 1.9'
gem 'rolify'

# mongo db gems
gem 'mongoid', '~> 4', github: 'mongoid/mongoid'
gem 'bson_ext'
gem 'public_activity'
gem 'kaminari'

# redis
gem 'redis', '~> 3.2.0'

# sidekiq
gem 'sidekiq', '~> 3.3.0'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'quiet_assets'
end

group :production do
  gem 'passenger'
  gem 'therubyracer',  platforms: :ruby
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'shoulda-matchers'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'spring'
end



# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

