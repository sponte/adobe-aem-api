require 'sinatra/base'

class MockAem < Sinatra::Application
  use Rack::Auth::Basic, 'Restricted Area' do |username, password|
    username == 'admin' and password == 'admin'
  end

  set :static, true
  set :public_folder, File.join(File.dirname(__FILE__), '../data')

  post '/bin/wcmcommand' do
    '<html><div id=Location href=/etc/replication/agents.author/stan /></html>'
  end

  get '/system/console/bundles/:id' do
    if params[:id] == 'uk.sponte.bundle'
      return "{}"
    end

    return 404
  end

  post '/system/console/bundles/?:id?' do
  	params.to_json
  end
end