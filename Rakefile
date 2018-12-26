require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

task :minitest_specs do
  Dir.glob('spec/lib/generators/**/test_*.rb').each do |test_file_path|
    system "ruby #{test_file_path}"
  end
end

RSpec::Core::RakeTask.new(:core_specs) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.exclude_pattern = 'spec/sample_app/spec/**/*_spec.rb'
end

RSpec::Core::RakeTask.new(:integration_specs) do |t|
  Dir.chdir 'spec/sample_app'

  t.pattern = Dir.glob('spec/**/*_spec.rb')
end

task spec: [:minitest_specs, :core_specs, :integration_specs]

task default: :spec
