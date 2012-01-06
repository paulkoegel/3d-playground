source 'http://rubygems.org'

gem 'rails', '3.1.3'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.1.0'
  gem 'compass', git: 'git://github.com/chriseppstein/compass', branch: 'master'
  gem 'coffee-rails', '~> 3.1.0'
  gem 'uglifier'
end

gem 'jquery-rails'
gem 'haml'

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

group :production do
  gem 'pg'
end
