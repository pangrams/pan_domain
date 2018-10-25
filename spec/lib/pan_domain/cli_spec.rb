require 'pan_domain/cli'

describe PanDomain::CLI do
  describe '--version' do
    it 'displays "PanDomain {VERSION}\n"' do
      expect { PanDomain::CLI.start ['--version'] }.to output(
        "PanDomain #{PanDomain::VERSION}\n"
      ).to_stdout
    end
  end

  describe '-v' do
    it 'displays "PanDomain {VERSION}\n"' do
      expect { PanDomain::CLI.start ['-v'] }.to output(
        "PanDomain #{PanDomain::VERSION}\n"
      ).to_stdout
    end
  end

  describe 'version' do
    it 'displays "PanDomain {VERSION}\n"' do
      expect { PanDomain::CLI.start ['version'] }.to output(
        "PanDomain #{PanDomain::VERSION}\n"
      ).to_stdout
    end
  end

  describe 'install' do
    # Suppress thor messages
    before { allow($stdout).to receive(:write) }

    it 'runs "rake pan_domain:install"' do
      expect_any_instance_of(Kernel).to(
        receive(:system).with 'rake pan_domain:install'
      )
  
      PanDomain::CLI.start ['install']
    end
  end

  describe 'generate_migrations' do
    # Suppress thor messages
    before { allow($stdout).to receive(:write) }

    it 'runs "rails g humain_domain:generate:migrations"' do
      expect_any_instance_of(Kernel).to(
        receive(:system).with 'rails g human_domain:generate:migrations'
      )
  
      PanDomain::CLI.start ['generate_migrations']
    end
  end
end
