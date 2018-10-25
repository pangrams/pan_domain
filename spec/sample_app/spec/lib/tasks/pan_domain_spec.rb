require 'rails_helper'

describe 'pan_domain:install' do
  subject(:task) { Rake::Task['pan_domain:install'] }

  # Suppress thor messages
  before { allow($stdout).to receive(:write) }
  after { task.reenable }

  it 'is not raise any exception' do
    expect { task.invoke }.not_to raise_exception
  end

  it 'runs "rake human_domain:install"' do
    expect(Rake::Task['human_domain:install']).to receive(:invoke)

    task.invoke
  end
end

describe 'pan_domain:db:seed' do
  subject(:task) { Rake::Task['pan_domain:db:seed'] }

  # Suppress thor messages
  before { allow($stdout).to receive(:write) }
  after { task.reenable }

  it 'is not raise any exception' do
    expect { task.invoke }.not_to raise_exception
  end

  it 'runs "rake human_domain:db:seed"' do
    expect(Rake::Task['human_domain:db:seed']).to receive(:invoke)

    task.invoke
  end
end

