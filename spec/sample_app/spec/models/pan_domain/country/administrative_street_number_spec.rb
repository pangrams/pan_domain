require 'rails_helper'

describe PanDomain::Country::AdministrativeStreetNumber do
  before(:all) do
    # Setup tables
    Rake::Task['country_domain:generate:migrations'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['country_domain:db:seed'].execute
  end

  it { is_expected.to validate_presence_of :street_number }
  it { is_expected.to belong_to :administrative_street_name }

  context 'validations' do
    let(:country) { PanDomain::Country::Country.first }

    let(:administrative_level_type) do
      PanDomain::Country::AdministrativeLevelType.create!(
        country: country, level: 1, name: 'Level 1'
      )
    end

    let(:administrative_division) do
      PanDomain::Country::AdministrativeDivision.create!(
        administrative_level_type: administrative_level_type, name: 'Division 1'
      )
    end

    let(:administrative_street_name) do
      PanDomain::Country::AdministrativeStreetName.new(
        administrative_division: administrative_division,
        name: 'St. First'
      )
    end

    subject(:administrative_street_number) do
      PanDomain::Country::AdministrativeStreetNumber.new(
        administrative_street_name: administrative_street_name,
        street_number: '12D'
      )
    end

    it do
      is_expected.to(
        validate_uniqueness_of(
          :street_number
        ).ignoring_case_sensitivity.scoped_to(:administrative_street_name_id)
      )
    end
  end
end
