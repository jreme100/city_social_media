source 'https://rubygems.org'

gem 'rails', '3.2.3'
gem 'sqlite3'
gem 'koala'
gem 'resque'
gem 'friendly_id'
gem 'jquery-rails'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'uglifier', '>= 1.0.3'
  gem 'bourbon'
end

group :production do
  gem 'thin'
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'jasmine'
  gem 'spork-rails'
  gem 'guard-spork'
  gem 'heroku', '~> 2.28.7'
  gem 'timecop'
  gem 'awesome_print'
end

group :test do
  gem 'vcr'
  gem 'webmock'
  gem 'cucumber-rails', require: false
  gem 'capybara-webkit'
  gem 'database_cleaner'
end


