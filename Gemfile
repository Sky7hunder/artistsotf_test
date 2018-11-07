source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'rails', '~> 5.2.1'
gem 'mongoid', '~> 7.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'pry'
  gem 'listen'
	gem 'factory_bot_rails'
	gem 'ffaker'
end

group :test do
	gem 'chromedriver-helper'
	gem 'capybara-webkit'
	gem 'capybara'
	gem 'database_cleaner', git: 'https://github.com/DatabaseCleaner/database_cleaner.git'
	gem 'rspec-rails'
	gem 'rspec_junit_formatter'
	gem 'selenium-webdriver'
	gem 'mongoid-rspec', git: 'https://github.com/mongoid-rspec/mongoid-rspec.git'
end
