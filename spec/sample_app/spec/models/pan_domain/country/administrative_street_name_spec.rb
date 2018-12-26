require 'rails_helper'

describe PanDomain::Country::AdministrativeStreetName do
  before(:all) do
    # Setup tables
    Rake::Task['country_domain:generate:migrations'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['country_domain:db:seed'].execute
  end

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to belong_to :administrative_division }
  it { is_expected.to have_many :administrative_street_numbers }

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

    subject(:administrative_street_name) do
      PanDomain::Country::AdministrativeStreetName.new(
        administrative_division: administrative_division,
        name: 'St. First'
      )
    end

    it do
      is_expected.to(
        validate_uniqueness_of(:name).ignoring_case_sensitivity.scoped_to(
          :administrative_division_id
        )
      )
    end
  end
end
