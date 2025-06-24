# frozen_string_literal: true

require 'puppet_x/binford2k/itemize'
require 'spec_helper'

describe Puppet_X::Binford2k::Itemize::Runner do
  context 'with puppet-stdlib manifests' do
    subject(:runner) { described_class.new({ manifests: puppetlabs_stdlib_fixture }) }

    it 'has no results yet' do
      expect(runner.results).to be_empty
    end

    it 'can be run' do
      expect { runner.run! }.not_to raise_error
    end

    context 'when run' do
      subject!(:results) do
        runner.run!
        runner.results
      end

      it 'found the expected kinds' do
        expect(results).to include(classes: Hash, types: Hash, functions: Hash)
      end

      it 'found the expected number of classes' do
        expect(results[:classes].size).to equal(3)
      end

      it 'found the expected number of functions' do
        expect(results[:functions].size).to equal(22)
      end

      it 'found the expected number of types' do
        expect(results[:types].size).to equal(5)
      end
    end
  end

  context 'with puppetlabs-apache manifests' do
    subject(:runner) { described_class.new({ manifests: puppetlabs_apache_fixture }) }

    it 'has no results yet' do
      expect(runner.results).to be_empty
    end

    it 'can be run' do
      expect { runner.run! }.not_to raise_error
    end

    context 'when run' do
      subject!(:results) do
        runner.run!
        runner.results
      end

      it 'found the expected kinds' do
        expect(results).to include(classes: Hash, types: Hash, functions: Hash)
      end

      it 'found the expected number of classes' do
        expect(results[:classes].size).to equal(70)
      end

      it 'found the expected number of functions' do
        expect(results[:functions].size).to equal(25)
      end

      it 'found the expected number of types' do
        expect(results[:types].size).to equal(20)
      end
    end
  end
end
