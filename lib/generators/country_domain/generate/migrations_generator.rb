require 'rails/generators'
require 'rails/generators/migration'
require 'active_record'

module CountryDomain
  module Generate
    class MigrationsGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      # Root directory
      source_root File.expand_path('../../../..', __dir__)

      class << self
        def next_migration_number(dirname)
          current_migration_timestamp = current_migration_number(dirname)
          next_migration_timestamp = "%.3d" % (current_migration_timestamp + 1)

          if ActiveRecord::Base.timestamped_migrations
            timestamp_str = Time.new.utc.strftime("%Y%m%d%H%M%S")

            # Check if timestamp is the same with previous migration
            # or smaller than current migration timestamp
            # due to fast generation in the same second
            if timestamp_str.to_i <= current_migration_timestamp
              next_migration_timestamp
            else
              timestamp_str
            end
          else
            next_migration_timestamp
          end
        end
      end

      # Creates migration files for Country Domain.
      #
      # Generated tables:
      # * administrative_divisions table
      # * administrative_level_types table
      # * administrative_street_names table
      # * administrative_street_numbers table
      # * countries table
      # * postal_codes table
      def create_migration_files
        source_dir = 'db/migrate/country_domain'
        destination_dir = 'db/migrate'

        migration_template(
          "#{source_dir}/0001_create_countries.rb",
          "#{destination_dir}/create_countries.rb"
        )

        migration_template(
          "#{source_dir}/0002_create_administrative_level_types.rb",
          "#{destination_dir}/create_administrative_level_types.rb"
        )

        migration_template(
          "#{source_dir}/0003_create_administrative_divisions.rb",
          "#{destination_dir}/create_administrative_divisions.rb"
        )

        migration_template(
          "#{source_dir}/0004_create_postal_codes.rb",
          "#{destination_dir}/create_postal_codes.rb"
        )

        migration_template(
          "#{source_dir}/0005_create_administrative_street_names.rb",
          "#{destination_dir}/create_administrative_street_names.rb"
        )

        migration_template(
          "#{source_dir}/0006_create_administrative_street_numbers.rb",
          "#{destination_dir}/create_administrative_street_numbers.rb"
        )
      end
    end
  end
end
