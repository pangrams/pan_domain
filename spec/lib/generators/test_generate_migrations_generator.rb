require 'minitest/spec'
require 'minitest/autorun'
require File.expand_path('../../../lib/generators/human_domain/generate/migrations_generator', __dir__)

class HumanDomainGenerateMigrationsGenerator < Rails::Generators::TestCase
  tests HumanDomain::Generate::MigrationsGenerator
  destination File.expand_path('../../dummy', __dir__)
  teardown :clean_migrations

  def clean_migrations
    Dir.glob("#{destination_root}/db/migrate/*.rb").each do |file_path|
      File.delete(file_path) if File.exist?(file_path)
    end
  end
  
  test 'generates blood classification system migration' do
    run_generator

    assert_migration 'db/migrate/create_blood_classification_systems.rb'
  end

  test 'generates blood group name migration' do
    run_generator

    assert_migration 'db/migrate/create_blood_group_names.rb'
  end

  test 'do not generate any migration with same timestamp' do
    dir_path = "#{destination_root}/db/migrate"
    migration_timestamps = []

    run_generator

    migration_files = Dir.glob("#{dir_path}/*_create_blood_group_names.rb")
    migration_files += Dir.glob(
      "#{dir_path}/*_create_blood_classification_systems.rb"
    )

    migration_files.each do |file_path|
      file_name = File.basename(file_path)
      timestamp_str = file_name[0...14]

      assert !migration_timestamps.include?(timestamp_str)

      migration_timestamps << timestamp_str
    end
  end
end
