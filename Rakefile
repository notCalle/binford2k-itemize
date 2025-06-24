# frozen_string_literal: true

require 'puppet_fixtures/tasks'
require 'rubocop/rake_task'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec:unit') do |t, _args|
  t.pattern = 'spec/unit/**/*_spec.rb'
end

desc 'Run spec tests and clean the fixtures directory if successful'
task spec: :'fixtures:prep' do |_t, args|
  Rake::Task['spec:unit'].invoke(*args.extras)
  Rake::Task['fixtures:clean'].invoke
end

RuboCop::RakeTask.new(:rubocop)

task default: [:spec, :rubocop]
