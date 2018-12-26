require 'rails_helper'

describe 'country_domain:generate:migrations' do
  subject(:task) { Rake::Task['country_domain:generate:migrations'] }

  # Suppress thor messages
  before { allow($stdout).to receive(:write) }
  after { task.reenable }

  it 'is not raise any exception' do
    expect { task.invoke }.not_to raise_exception
  end

  it 'runs "rails g country_domain:generate:migrations"' do
    expect_any_instance_of(Kernel).to(
      receive(:system).with 'rails g country_domain:generate:migrations'
    )

    task.invoke
  end
end

describe 'country_domain:db:seed' do
  subject(:task) { Rake::Task['country_domain:db:seed'] }

  before(:all) do
    # Setup tables
    Rake::Task['country_domain:generate:migrations'].invoke
    Rake::Task['db:migrate'].execute
  end

  # Suppress thor messages
  # before { allow($stdout).to receive(:write) }
  after { task.reenable }

  it 'is not raise any exception' do
    expect { task.invoke }.not_to raise_exception
  end

  it 'runs "PanDomain::Country::Engine.load_seed"' do
    expect(PanDomain::Country::Engine).to receive(:load_seed)

    task.invoke
  end

  it 'creates 241 records in "countries" table' do
    expect do
      task.invoke
    end.to change { PanDomain::Country::Country.count }.from(0).to(241)
  end

  it 'creates 19 records in "administrative_level_types" table' do
    expect do
      task.invoke
    end.to change {
      PanDomain::Country::AdministrativeLevelType.count
    }.from(0).to(19)
  end

  it 'creates 548 records in "administrative_divisions" table' do
    expect do
      task.invoke
    end.to change {
      PanDomain::Country::AdministrativeDivision.count
    }.from(0).to(34 + 98 + 416)
  end
end

describe 'country_domain:install' do
  subject(:task) { Rake::Task['country_domain:install'] }

  # Suppress thor messages
  before { allow($stdout).to receive(:write) }
  after { task.reenable }

  it 'is not raise any exception' do
    expect { task.invoke }.not_to raise_exception
  end

  it 'runs "rake country_domain:generate:migrations"' do
    expect(Rake::Task['country_domain:generate:migrations']).to receive(:invoke)

    task.invoke
  end

  it 'runs "rake db:migrate"' do
    expect(Rake::Task['db:migrate']).to receive(:invoke)

    task.invoke
  end

  it 'runs "rake country_domain:db:seed"' do
    expect(Rake::Task['country_domain:db:seed']).to receive(:invoke)

    task.invoke
  end
end
