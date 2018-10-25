require 'rails_helper'

describe PanDomain::Human::BloodGroupName do
  before(:all) do
    # Setup tables
    Rake::Task['human_domain:generate:migrations'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
  end

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :symbol }
  it { is_expected.to belong_to :blood_classification_system }

  context 'validations' do
    subject(:blood_group_name) do
      PanDomain::Human::BloodGroupName.new(
        blood_classification_system: PanDomain::Human::BloodClassificationSystem.first,
        name: 'TEST', symbol: 'A_SYMBOL'
      )
    end

    it do
      is_expected.to(
        validate_uniqueness_of(:name).scoped_to(
          :blood_classification_system_id
        ).ignoring_case_sensitivity
      )
    end

    it do
      is_expected.to(
        validate_uniqueness_of(:symbol).scoped_to(
          :blood_classification_system_id
        ).ignoring_case_sensitivity
      )
    end
  end
end
