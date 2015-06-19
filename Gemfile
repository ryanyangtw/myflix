source 'https://rubygems.org'
ruby '2.2.2'

gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'rails', '4.1.1'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'pg'

gem 'bootstrap_form'
gem 'bcrypt'

gem 'fabrication'
gem 'faker'

gem "figaro"

gem 'sidekiq'

gem 'carrierwave', "~> 0.10.0"
gem 'carrierwave-aws'
gem 'mini_magick'

group :development do
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'letter_opener'
end

group :development, :test do
  gem 'pry'
  gem 'pry-nav'
  gem 'rspec-rails', '~> 3.2.0'
  gem 'guard-rspec'
  gem 'growl'
end

group :test do
  gem 'shoulda-matchers'
  gem 'database_cleaner', '1.2.0'
  gem 'capybara'
  gem 'launchy' # save_and_open_page
  gem 'capybara-email'
end

group :staging, :production do
  gem 'rails_12factor'
  gem 'unicorn'
  gem 'rack-timeout'
  gem "sentry-raven", :git => "https://github.com/getsentry/raven-ruby.git"
end

group :staging do
  gem 'recipient_interceptor'
end

