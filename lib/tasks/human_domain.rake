thor = Thor.new

namespace :human_domain do
  namespace :generate do
    desc 'Generates all migrations in Human Domain to application'
    task :migrations do
      thor.say_status 'start', 'Generate migrations'

      system 'rails g human_domain:generate:migrations'

      thor.say_status 'finish', 'Generate migrations'
    end
  end

  namespace :db do
    desc 'Loads the seed data in Human Domain to application'
    task :seed do
      thor.say_status 'start', 'Seeding Human domain data'

      config = ActiveRecord::Base.configurations[Rails.env]
      config ||= Rails.application.config.database_configuration[Rails.env]
      config['pool'] = ENV['DB_POOL'] || ENV['RAILS_MAX_THREADS'] || 5

      ActiveRecord::Base.establish_connection(config)

      PanDomain::Human::Engine.load_seed

      ActiveRecord::Base.connection_pool.disconnect!
      thor.say_status 'finish', 'Seeding Human domain data'
    end
  end

  desc 'Install Human Domain to application'
  task :install do
    thor.say_status 'start', 'Install Human Domain'

    Rake::Task['human_domain:generate:migrations'].invoke

    thor.say_status 'run', 'db:migrate'
    Rake::Task['db:migrate'].invoke

    Rake::Task['human_domain:db:seed'].invoke

    thor.say_status 'finish', 'Install Human Domain'
  end
end
