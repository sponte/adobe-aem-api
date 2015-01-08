require 'spec_helper'

module Adobe
  module Aem
    describe Api do
      describe 'Default values' do
        before(:all) do
          MockAem.run
        end

        after(:all) do
          MockAem.quit!
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
        subject.should have_at_least(2).agents
        expect(subject).to have_at_least(1).agents

        expect(subject.agents['agents.author']['publish-1']['jcr:content']['jcr:title']).to eq('Publish 1')
      end

      it 'should create agent' do
        subject.create_agent('agents.author', 'stan')
      end
    end

    describe "System" do
      subject do
        @options = {}
        @options[:port] = 4567

        Adobe::Aem::Api.new(@options).system
      end

      it "should uninstall a bundle" do
        b = subject.uninstall_bundle("uk.sponte.bundle").body
        expect(JSON.parse(b)["action"]).to eq("uninstall")
      end

      it "should refresh_package_imports" do
        b = subject.refresh_bundle_imports("uk.sponte.bundle").body
        expect(JSON.parse(b)["action"]).to eq("refresh")
      end

      it "should upload package" do
        tempfile = Tempfile.new('upload_package.tmp')
        tempfile.close

        b = subject.install_bundle(tempfile.path).body

        puts b

        expect(JSON.parse(b)["action"]).to eq("install")

        File.delete(tempfile.path)
      end

    end
  end
end

