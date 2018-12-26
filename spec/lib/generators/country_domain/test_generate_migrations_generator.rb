require 'minitest/spec'
require 'minitest/autorun'
require File.expand_path('../../../../lib/generators/country_domain/generate/migrations_generator', __dir__)

class CountryDomainGenerateMigrationsGenerator < Rails::Generators::TestCase
  tests CountryDomain::Generate::MigrationsGenerator
  destination File.expand_path('../../../sample_app', __dir__)
  teardown :clean_migrations

  def clean_migrations
    Dir.glob("#{destination_root}/db/migrate/*.rb").each do |file_path|
      File.delete(file_path) if File.exist?(file_path)
    end
  end

  test 'generates country migration' do
    run_generator

    assert_migration 'db/migrate/create_countries.rb'
  end

  test 'generates administrative level type migration' do
    run_generator

    assert_migration 'db/migrate/create_administrative_level_types.rb'
  end

  test 'generates administrative division migration' do
    run_generator

    assert_migration 'db/migrate/create_administrative_divisions.rb'
  end

  test 'generates postal code migration' do
    run_generator

    assert_migration 'db/migrate/create_postal_codes.rb'
  end

  test 'generates administrative street name migration' do
    run_generator

    assert_migration 'db/migrate/create_administrative_street_names.rb'
  end

  test 'generates administrative street number migration' do
    run_generator

    assert_migration 'db/migrate/create_administrative_street_numbers.rb'
  end

  test 'do not generate any migration with same timestamp' do
    dir_path = "#{destination_root}/db/migrate"
    migration_timestamps = []

    run_generator

    migration_files = Dir.glob("#{dir_path}/*_create_countries.rb")
    migration_files += Dir.glob(
      "#{dir_path}/*_create_administrative_level_types.rb"
    )
    migration_files += Dir.glob(
      "#{dir_path}/*_create_administrative_divisions.rb"
    )
    migration_files += Dir.glob("#{dir_path}/*_create_postal_codes.rb")
    migration_files += Dir.glob(
      "#{dir_path}/*_create_administrative_street_names.rb"
    )
    migration_files += Dir.glob(
      "#{dir_path}/*_create_administrative_street_numbers.rb"
    )

    migration_files.each do |file_path|
      file_name = File.basename(file_path)
      timestamp_str = file_name[0...14]

      assert !migration_timestamps.include?(timestamp_str)

      migration_timestamps << timestamp_str
    end
  end
end
