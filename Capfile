require "capistrano/setup"
require "capistrano/deploy"

# Configure to use git
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

require "capistrano/bundler"
require "capistrano/rbenv"
require 'capistrano/rails'
require "capistrano/rails/assets"
require "capistrano/rails/migrations"
require 'capistrano/puma'
install_plugin Capistrano::Puma

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
