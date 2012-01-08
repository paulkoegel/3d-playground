source 'http://rubygems.org'

gem 'rails', '3.1.3'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.1.0'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'haml'
gem 'compass', '~> 0.12.alpha'

group :development, :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers', :git => 'git://github.com/thoughtbot/shoulda-matchers.git'
end

group :test do
  gem 'turn', :require => false # Pretty printed test output
  gem 'rspec'
  gem 'simplecov'
end

group :development do
  gem 'heroku'
end
