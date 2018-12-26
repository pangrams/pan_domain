require 'rails_helper'

describe PanDomain::Country::Country do
  before(:all) do
    # Setup tables
    Rake::Task['country_domain:generate:migrations'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['country_domain:db:seed'].execute
  end

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to have_many :administrative_level_types }
  
  context 'validations' do
    subject(:country) { PanDomain::Country::Country.new(name: 'TEST') }

    it { is_expected.to validate_uniqueness_of(:name).ignoring_case_sensitivity }
  end
end
