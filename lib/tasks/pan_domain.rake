thor = Thor.new

namespace :pan_domain do
  desc 'Install all domains'
  task :install do
    thor.say_status 'start', 'Install All Domains'

    Rake::Task['human_domain:install'].invoke

    thor.say_status 'finish', 'Install All Domains'
  end
end
