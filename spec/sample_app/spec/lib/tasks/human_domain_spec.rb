require 'rails_helper'

describe 'human_domain:generate:migrations' do
  subject(:task) { Rake::Task['human_domain:generate:migrations'] }

  # Suppress thor messages
  before { allow($stdout).to receive(:write) }
  after { task.reenable }

  it 'is not raise any exception' do
    expect { task.invoke }.not_to raise_exception
  end

  it 'runs "rails g humain_domain:generate:migrations"' do
    expect_any_instance_of(Kernel).to(
      receive(:system).with 'rails g human_domain:generate:migrations'
    )

    task.invoke
  end
end

describe 'human_domain:db:seed' do
  subject(:task) { Rake::Task['human_domain:db:seed'] }

  before(:all) do
    # Setup tables
    Rake::Task['human_domain:generate:migrations'].invoke
    Rake::Task['db:migrate'].execute
  end

  # Suppress thor messages
  before { allow($stdout).to receive(:write) }
  after { task.reenable }

  it 'is not raise any exception' do
    expect { task.invoke }.not_to raise_exception
  end

  it 'runs "PanDomain::Human::Engine.load_seed"' do
    expect(PanDomain::Human::Engine).to receive(:load_seed)

    task.invoke
  end

  it 'creates 2 records in "blood_classification_systems" table' do
    expect do
      task.invoke
    end.to change {
      PanDomain::Human::BloodClassificationSystem.count
    }.from(0).to(2)
  end

  it 'creates 6 records in "blood_group_names" table' do
    expect do
      task.invoke
    end.to change { PanDomain::Human::BloodGroupName.count }.from(0).to(6)
  end
end

describe 'human_domain:install' do
  subject(:task) { Rake::Task['human_domain:install'] }

  # Suppress thor messages
  before { allow($stdout).to receive(:write) }
  after { task.reenable }

  it 'is not raise any exception' do
    expect { task.invoke }.not_to raise_exception
  end

  it 'runs "rake human_domain:generate:migrations"' do
    expect(Rake::Task['human_domain:generate:migrations']).to receive(:invoke)

    task.invoke
  end

  it 'runs "rake db:migrate"' do
    expect(Rake::Task['db:migrate']).to receive(:invoke)

    task.invoke
  end

  it 'runs "rake human_domain:db:seed"' do
    expect(Rake::Task['human_domain:db:seed']).to receive(:invoke)

    task.invoke
  end
end
