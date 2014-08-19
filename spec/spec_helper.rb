require 'rubygems' if RUBY_VERSION.to_f < 1.9

require 'adobe-aem-api'
require 'webmock/rspec'

require 'helpers/mock_aem'

RSpec.configure do |config|
  config.before(:each) do
    stub_request(:any, //).to_rack(MockAem)
  end
end