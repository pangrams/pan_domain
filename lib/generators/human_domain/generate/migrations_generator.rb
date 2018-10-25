require 'rails/generators'
require 'rails/generators/migration'
require 'active_record'

module HumanDomain
  module Generate
    class MigrationsGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      # Root directory
      source_root File.expand_path('../../../..', __dir__)

      class << self
        def next_migration_number(dirname)
          current_migration_timestamp = current_migration_number(dirname)

          if ActiveRecord::Base.timestamped_migrations
            timestamp_str = Time.new.utc.strftime("%Y%m%d%H%M%S")

            # Check if timestamp is the same with previous migration
            # due to fast generation in the same second
            if timestamp_str == current_migration_timestamp.to_s
              "%.3d" % (current_migration_timestamp + 1)
            else
              timestamp_str
            end
          else
            "%.3d" % (current_migration_timestamp + 1)
          end
        end
      end

      def create_migration_files
        source_dir = 'db/migrate/human_domain'
        destination_dir = 'db/migrate'

        migration_template(
          "#{source_dir}/0001_create_blood_classification_systems.rb",
          "#{destination_dir}/create_blood_classification_systems.rb"
        )

        migration_template(
          "#{source_dir}/0002_create_blood_group_names.rb",
          "#{destination_dir}/create_blood_group_names.rb"
        )
      end
    end
  end
end
