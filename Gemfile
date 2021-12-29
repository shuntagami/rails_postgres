source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'rails', '~> 6.1.4.4'
gem 'pg'
gem 'puma'
gem 'webpacker'
gem 'jbuilder'
# gem 'redis', '~> 4.0'
# gem 'bcrypt'
# gem 'image_processing', '~> 1.2'
gem 'bootsnap', require: false

gem 'dotenv-rails'
gem 'rack-cors'
gem 'global'
gem 'slim-rails'
gem 'sentry-ruby'
gem 'committee-rails'

group :development, :test do
  gem 'brakeman', require: false
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end

group :development do
  gem 'web-console'
  gem 'rack-mini-profiler'
  gem 'listen'
end

group :test do
  gem 'simplecov', require: false
end
