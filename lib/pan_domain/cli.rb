require 'thor'

module PanDomain
  class Cli < Thor
    available_domains = []

    desc 'version', 'Display version'
    map %w[-v --version] => :version
    def version
      say "PanDomain #{VERSION}"
    end

    # Dynamically get all available domains from rake task files
    Dir.glob("#{__dir__}/../tasks/*_domain.rake").each do |file_path|
      file_name = File.basename(file_path)
      # exclude pan_domain rake file
      next if file_name.include?('pan_domain')
      file_name = file_name.sub('_domain.rake', '').capitalize
      available_domains << "- #{file_name}\n"
    end

    desc 'install', 'Install all domains'
    long_desc <<-INSTALL_DOMAINS

    'install' will install all available domains.

    Installing a domain means it will generate migrations
    to your Rails application, run 'rake db:migrate' as a bash command,
    and seed data for each domain if available.

    Available domains are:

    \e[34m#{available_domains.join("\n")}\e[0m
    INSTALL_DOMAINS
    def install
      system 'rake pan_domain:install'
    end

    desc 'generate_migrations', 'Generate migrations for all domains'
    def generate_migrations
      say_status 'start', 'Generate all migrations'

      system 'rails g human_domain:generate:migrations'

      say_status 'finish', 'Generate all migrations'
    end

    desc 'generate_seeds', 'Generate seed data for all domains'
    def generate_seeds
      system 'rake human_domain:db:seed'
    end
  end
end
