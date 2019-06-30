source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# This one is important
gem 'rails', '~> 6.0.0.rc1'

############
# DATABASE #
############
gem 'sqlite3', '~> 1.4'
gem 'strip_attributes'
gem 'bcrypt'

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
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # Finds those nasty N+1 inefficiencies
  gem 'bullet'

  # Use dev branch until rails 6 and rspec rails 4 drops
  gem 'rspec-rails', git: 'https://github.com/rspec/rspec-rails', branch: '4-0-dev'
  gem 'rspec-core', git: 'https://github.com/rspec/rspec-core'
  gem 'rspec-mocks', git: 'https://github.com/rspec/rspec-mocks'
  gem 'rspec-support', git: 'https://github.com/rspec/rspec-support'
  gem 'rspec-expectations', git: 'https://github.com/rspec/rspec-expectations'

  # Factory bot
  gem 'factory_bot'
  gem 'factory_bot_rails'
end

group :development do
  # Improved error messages
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'awesome_print'

  # Interactive rails console
  gem 'web-console', '>= 3.3.0'

  # Rails gem extension
  gem 'meta_request'

  # Style guide enforcer
  gem 'rubocop-rails'

  # Spring application pre-loader
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
