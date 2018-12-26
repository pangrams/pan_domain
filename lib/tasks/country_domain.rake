thor = Thor.new

namespace :country_domain do
  namespace :generate do
    desc 'Generates all migrations in Country Domain to application'
    task :migrations => :environment do
      thor.say_status 'start', 'Generate migrations'

      system 'rails g country_domain:generate:migrations'

      thor.say_status 'finish', 'Generate migrations'
    end
  end

  namespace :db do
    desc 'Loads the seed data in Country Domain to application'
    task :seed => :environment do
      thor.say_status 'start', 'Seeding Country domain data'

      config = ActiveRecord::Base.configurations[Rails.env]
      config ||= Rails.application.config.database_configuration[Rails.env]
      config['pool'] = ENV['DB_POOL'] || ENV['RAILS_MAX_THREADS'] || 5

      ActiveRecord::Base.establish_connection(config)

      PanDomain::Country::Engine.load_seed

      thor.say_status 'finish', 'Seeding Country domain data'
    end
  end

  desc 'Install Country Domain to application'
  task :install => :environment do
    thor.say_status 'start', 'Install Country Domain'

    Rake::Task['country_domain:generate:migrations'].invoke
    
    thor.say_status 'run', 'db:migrate'
    Rake::Task['db:migrate'].invoke

    Rake::Task['country_domain:db:seed'].invoke

    thor.say_status 'finish', 'Install Country Domain'
  end
end
