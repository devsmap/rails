source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

# Core
gem 'rails', '~> 6.1.3'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'rack-cors'
gem 'thwait'

# Security
gem 'bcrypt', '~> 3.1.7'
gem 'gemsurance'
gem 'rack-attack'

# Monitoring
gem 'airbrake'

# Backend
gem 'http_accept_language'
gem "bullet"
gem 'devise'
gem 'sixarm_ruby_unaccent'
gem "validate_url"
gem 'translation'
gem "punching_bag"
gem 'colorize'
gem 'httparty'
gem 'acts_as_paranoid'
gem "enumerize"
gem 'postmark-rails'
gem 'ajax-datatables-rails'

# Frontend
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'simple_form'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '~> 3.2'
  gem "better_errors"
  gem "binding_of_caller"  
  gem 'faker', '~> 2.14'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
