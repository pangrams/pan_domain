lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pan_domain/version'

Gem::Specification.new do |spec|
  spec.name        = 'pan_domain'
  spec.version     = PanDomain::VERSION
  spec.authors     = ['Yosua Jaya Candra']
  spec.email       = 'yosuajayacandra@gmail.com'
  spec.summary     = 'A tool for create common tables powered by ActiveRecord'
  spec.description = 'A gem which create common tables and data' \
                     ' which prioritize on data integrity.'
  spec.homepage    = 'https://github.com/pangrams/pan_domain'
  spec.license     = 'MIT'
  spec.metadata    = {
    'allowed_push_host' => 'https://rubygems.org',
    'source_code_uri'   => 'https://github.com/pangrams/pan_domain'
  }

  spec.required_ruby_version = '>= 2.3.8'

  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end

  spec.executables   = ['pan_domain']
  spec.require_paths = ['lib']
  spec.test_files    = Dir.glob('spec/**/*.rb')

  spec.add_dependency 'rails', '~> 5.2'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pg', '~> 1.1'
  spec.add_development_dependency 'rspec-rails', '~> 3.8'
  spec.add_development_dependency 'shoulda-matchers', '~> 4.0.0.rc1'
  spec.add_development_dependency 'pry-byebug', '~> 3.6'
end
