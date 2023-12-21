git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby "3.2.2"
source "https://rubygems.org"
gem "bootsnap", require: false
gem "devise", "~> 4.9"
gem "faker"
gem "heroicon"
gem "importmap-rails"
gem "jbuilder"
gem 'pagy'
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.8"
gem "ransack", "~> 4.1"
gem "sprockets-rails"
gem "sqlite3", "~> 1.4"
gem "stimulus-rails"
gem 'tailwindcss-rails'
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem 'launchy'
  gem "selenium-webdriver"
  gem 'shoulda-matchers'
end