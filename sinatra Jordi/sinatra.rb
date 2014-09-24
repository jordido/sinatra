require 'sinatra'
require 'sinatra/reloader'

set :port, 3000
#set :bind, '0.0.0.0'

class Spotinatra
	attr_accessor :songs
	def initialize
		@songs = []
	end
end

list_of_songs ||= Spotinatra.new

get '/' do
	@list = list_of_songs.songs
	erb :index  # goes to views folder and looks for the file index.erb (html)
end

post '/new/songs' do
	artist = params[:artist]
  song = params[:name]
	if list_of_songs.songs.size < 5
		p params
	  list_of_songs.songs << [params[:artist], params[:song]]
	  @list = list_of_songs.songs
		erb :index
	else
		redirect to('/enough')
	end
end

get '/find/songs/:artist' do
	@found = list_of_songs.songs.select do |artist, _|
		artist == params[:artist]
	end
	erb :find
end


# , will be POST, and will have both “name” and “artist”
	
get '/enough' do
	"IS WORTH F**ING NOTHING"
#	erb :index
end

__END__

curl -L localhost:3000/songs/new/Frank%20Sinatra/My%20Way
curl -L localhost:3000/songs/new/Frank%20Sinatra/My%20Other%20Way
curl -L localhost:3000/songs/new/Peret/Borriquito%20como%20tú
curl -L localhost:3000/songs/new/Nirvana/Shot%20in%20my%20head
curl -L localhost:3000/songs/new/Enrique y Ana/123%20pajarito%20inglés

