require 'sinatra/base'

class MockAem < Sinatra::Application
  use Rack::Auth::Basic, 'Restricted Area' do |username, password|
    username == 'admin' and password == 'admin'
  end

  set :static, true
  set :public_folder, File.join(File.dirname(__FILE__), '../data')
end