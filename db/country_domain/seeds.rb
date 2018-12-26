require_dependency File.expand_path('../../app/models/pan_domain/country/country', __dir__)
require 'pry'
module PanDomain
  module Country
    if ActiveRecord::Base.connection.table_exists?(Country.table_name)
      country_data = YAML.load_file(
        File.expand_path('countries.yml', __dir__)
      )
      country_names = country_data['countries']

      unless country_names.size == Country.count
        country_names.each do |country_name|
          Country.where(name: country_name).first_or_create
        end
      end
    end

    if ActiveRecord::Base.connection.table_exists?(AdministrativeLevelType.table_name)
      administrative_level_type_data = YAML.load_file(
        File.expand_path('administrative_level_types.yml', __dir__)
      )

      administrative_level_type_data.each do |data|
        country = Country.find_by(name: data['country_name'])
        next unless country

        data['administrative_level_types'].each do |adm_level_type_params|
          AdministrativeLevelType.where(
            country: country, level: adm_level_type_params['level'],
            name: adm_level_type_params['name']
          ).first_or_create
        end
      end
    end

    if ActiveRecord::Base.connection.table_exists?(AdministrativeLevelType.table_name)
      administrative_division_data = YAML.load_file(
        File.expand_path('administrative_divisions.yml', __dir__)
      )
      countries_cache = {}
      adm_level_types_cache = {}

      administrative_division_data.each do |data|
        country_name = data['country_name']
        country = Country.find_by(name: country_name)

        unless countries_cache.key?(country_name)
          countries_cache[country_name] = country
        end

        next unless countries_cache[country_name]

        data['administrative_divisions'].each do |adm_division_params|
          adm_level_type_params = adm_division_params['administrative_level_type']
          level = adm_level_type_params['level']
          level_type_name = adm_level_type_params['name']
          cache_key = "#{country_name}:#{level}:#{level_type_name}"
          adm_level_type = AdministrativeLevelType.find_by(
            country: countries_cache[country_name],
            level: level, name: level_type_name
          )

          unless adm_level_types_cache.key?(cache_key)
            adm_level_types_cache[cache_key] = adm_level_type
          end

          next unless adm_level_types_cache[cache_key]

          adm_division_params['divisions'].each do |division_name|
            AdministrativeDivision.where(
              administrative_level_type: adm_level_type,
              name: division_name
            ).first_or_create
          end
        end
      end
    end
  end
end
