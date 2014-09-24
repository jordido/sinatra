require 'sinatra'

set :port, 3000
set :bind, '0.0.0.0'

 get '/say-my-name' do
  'Walter'
 end