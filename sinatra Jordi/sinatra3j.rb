require 'sinatra'

set :port, 3000
set :bind, '0.0.0.0'

class Spotinatra
	attr_accessor :songs
	def initialize
		@songs = []

	end
end

list_of_songs = Spotinatra.new

get '/' do
	list_of_songs.songs.inspect
	# erb :index
end


get %r{/songs/(new|create)/([\w]+)/([\w]+)} do
	if list_of_songs.songs.size < 3
	  list_of_songs.songs << [params['captures'][1], params['captures'][2]]
	  redirect to('/')
		# " #{params[:artist]} #{params[:song]}"
	else
		redirect to('/enough')
	end

end

get "/new/songs/:artist/:song" do
	redirect to "/songs/new/#{params[:artist]}/#{params[:song]}"
end

# , will be POST, and will have both “name” and “artist”
	
get '/enough' do
	"IS WORTH F**ING NOTHING"
end

