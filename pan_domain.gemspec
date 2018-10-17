lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pan_domain/version'

Gem::Specification.new do |spec|
  spec.name          = 'pan_domain'
  spec.version       = PanDomain::VERSION
  spec.authors       = ['Yosua Jaya Candra']
  spec.email         = ['yosuajayacandra@gmail.com']

  spec.summary       = 'A tool for create common tables powered by ActiveRecord'
  spec.description   = 'A gem which create common tables and data' \
                       ' which prioritize on data integrity.'
  spec.homepage      = 'https://github.com/pangrams/pan_domain'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org.
  # To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host
  # or delete this section to allow pushing to any host.
  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem
  # that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end

  spec.executables   = ['pan_domain']
  spec.require_paths = ['lib']

  spec.add_dependency 'rails', '~> 5.2'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
