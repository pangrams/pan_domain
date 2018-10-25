require 'rails_helper'

describe PanDomain::Human::BloodClassificationSystem do
  before(:all) do
    # Setup tables
    Rake::Task['human_domain:generate:migrations'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
  end

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to have_many :blood_group_names }

  context 'validations' do
    subject(:blood_classification_system) do
      PanDomain::Human::BloodClassificationSystem.new(
        name: 'TEST', description: 'A description'
      )
    end

    it { is_expected.to validate_uniqueness_of(:name).ignoring_case_sensitivity }
  end

  describe '.abo' do
    before do
      @abo = PanDomain::Human::BloodClassificationSystem.find_by(name: 'ABO')
    end

    it 'returns record correctly' do
      expect(PanDomain::Human::BloodClassificationSystem.abo).to eq @abo
    end
  end

  describe '.rhesus' do
    before do
      @rhesus = PanDomain::Human::BloodClassificationSystem.find_by(
        name: 'Rhesus'
      )
    end

    it 'returns record correctly' do
      expect(PanDomain::Human::BloodClassificationSystem.rhesus).to eq @rhesus
    end
  end
end
