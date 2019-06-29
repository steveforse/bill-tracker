Rake::Task['test'].clear
namespace :test do
  Rake::Task['spec'].invoke
end
