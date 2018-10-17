thor = Thor.new

namespace :pan_domain do
  desc 'Install all domains'
  task :install do
    thor.say_status 'start', 'Install All Domains'

    Rake::Task['human_domain:install'].invoke

    thor.say_status 'finish', 'Install All Domains'
  end

  namespace :db do
    desc 'Loads seed data from all domains'
    task :seed do
      thor.say_status 'start:', 'Seed data from All Domains'

      Rake::Task['human_domain:db:seed'].invoke

      thor.say_status 'finish:', 'Seed data from All Domains'
    end
  end
end
