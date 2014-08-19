require 'spec_helper'

module Adobe
  module Aem
    describe Api do
      describe 'Default values' do
        before(:all) do
          @sinatra_app = MockAem.run
        end

        after(:all) do
          @sinatra_app.quit!
        end

        subject do
          Adobe::Aem::Api.new
        end

        it 'should set default values' do
          expect(subject.context.configuration.hostname).to eq('localhost')
          expect(subject.context.configuration.port).to eq(4502)
          expect(subject.context.configuration.username).to eq('admin')
          expect(subject.context.configuration.password).to eq('admin')
        end
      end

      it 'should expose replication' do
        expect(subject.replication).not_to be_nil
      end
    end

    describe Replication do
      subject do
        @options = {}
        @options[:port] = 4567

        Adobe::Aem::Api.new(@options).replication
      end

      it 'should return list of replication agents' do
        subject.should have_at_least(2).agent_types
        expect(subject).to have_at_least(1).agent_types

        expect(subject.agents['agents.author']['publish-1']['jcr:content']['jcr:title']).to eq('Publish 1')
      end

      it 'should create agent' do
        subject.create_agent('agents.author', 'stan')
      end
    end
  end
end

