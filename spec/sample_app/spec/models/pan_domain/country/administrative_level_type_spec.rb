require 'rails_helper'

describe PanDomain::Country::AdministrativeLevelType do
  before(:all) do
    # Setup tables
    Rake::Task['country_domain:generate:migrations'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['country_domain:db:seed'].execute
  end

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :level }
  it { is_expected.to belong_to :country }
  it { is_expected.to have_many :administrative_divisions }
  
  context 'validations' do
    let(:country) { PanDomain::Country::Country.first }

    subject(:administrative_level_type) do
      PanDomain::Country::AdministrativeLevelType.new(
        country_id: country.id, level: 1, name: 'TEST'
      )
    end

    it do
      is_expected.to(
        validate_uniqueness_of(:name).ignoring_case_sensitivity.scoped_to(
          :country_id
        )
      )
    end
  end
end
