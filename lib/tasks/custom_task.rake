# frozen_string_literal: true

# require_relative '../../config/application'
require 'rubocop/rake_task'
require 'bundler/audit/task'
require 'reek/rake/task'

Rake::Task[:test].clear

RuboCop::RakeTask.new(:rubocop)
Bundler::Audit::Task.new
Reek::Rake::Task.new

namespace :brakeman do
  desc 'Run Brakeman'
  task :run, :output_files do |_t, args|
    require 'brakeman'

    files = args[:output_files].split(' ') if args[:output_files]
    Brakeman.run app_path: '.', output_files: files, print_report: true
  end
end

task :test do
  Rake::Task['brakeman:run'].invoke
  sh 'bundle audit check --update'
  Rake::Task['bundle:audit'].invoke
  Rake::Task['reek'].invoke
  Rake::Task['rubocop'].invoke
  Rake::Task['spec'].invoke
end
