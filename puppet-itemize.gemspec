# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('lib', __dir__)
require 'puppet_x/binford2k/itemize/version'
require 'date'

Gem::Specification.new do |s|
  s.name                  = 'puppet-itemize'
  s.version               = Puppet_X::Binford2k::Itemize::VERSION
  s.date                  = Date.today.to_s
  s.summary               = 'Count the number of types, classes, functions used in Puppet manifest(s).'
  s.license               = 'Apache-2.0'
  s.email                 = 'ben.ford@puppet.com'
  s.homepage              = 'https://github.com/binford2k/binford2k-itemize'
  s.authors               = ['Ben Ford']
  s.require_path          = 'lib'
  s.executables           = %w[puppet-itemize]
  s.files                 = %w[CHANGELOG.md README.md LICENSE]
  s.files                += Dir.glob('lib/**/*')
  s.files                += Dir.glob('bin/**/*')
  s.required_ruby_version = Gem::Requirement.new('>= 2.5.0')
  s.add_runtime_dependency('puppet', '>= 7.0', '< 8.0')

  s.description = <<-DESC
  Run this command with a space separated list of either manifest file paths, or
  directories containing manifests. If omitted, it will default to inspecting all
  manifests in the manifests directory, so you can just run this in the root of a
  Puppet module and it will do the right thing.
  DESC
end
