# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# This one is important
gem 'rails', '~> 6.0.0.rc1'

############
# DATABASE #
############
gem 'bcrypt'
gem 'sqlite3', '~> 1.4'
gem 'strip_attributes'

##############
# VALIDATORS #
##############
gem 'date_validator'

##############
# DECORATORS #
##############
gem 'draper'

############
# HTML/CSS #
############
gem 'sass-rails', '~> 5'
gem 'slim-rails'

###########
# HELPERS #
###########
gem 'rezort', git: 'https://github.com/steveforse/rezort'
gem 'simple_form'

##########
# SERVER #
##########
gem 'puma', '~> 3.11'

# Reduces boot times through caching
gem 'bootsnap', '>= 1.4.2', require: false

##############
# JAVASCRIPT #
#############
gem 'jbuilder', '~> 2.5'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # Finds those nasty N+1 inefficiencies
  gem 'bullet'

  # Use dev branch until rails 6 and rspec rails 4 drops
  gem 'rspec-core', git: 'https://github.com/rspec/rspec-core'
  gem 'rspec-expectations', git: 'https://github.com/rspec/rspec-expectations'
  gem 'rspec-mocks', git: 'https://github.com/rspec/rspec-mocks'
  gem 'rspec-rails', git: 'https://github.com/rspec/rspec-rails', branch: '4-0-dev'
  gem 'rspec-support', git: 'https://github.com/rspec/rspec-support'

  # Factory bot
  gem 'factory_bot'
  gem 'factory_bot_rails'

  # Create some fake data for our factories
  gem 'faker'
end

group :development do
  # Improved error messages
  gem 'awesome_print'
  gem 'better_errors'
  gem 'binding_of_caller'

  # Interactive rails console
  gem 'web-console', '>= 3.3.0'

  # Rails gem extension
  gem 'meta_request'

  # Style guide enforcer
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'

  # Spring application pre-loader
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'

  # Test helpers for more complex behavior
  gem 'shoulda-matchers'
end
