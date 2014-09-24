require 'sinatra'
require 'sinatra/reloader'

set :port, 3000
#set :bind, '0.0.0.0'

class Spotinatra
	attr_accessor :songs
	def initialize
		@songs = []
	end

	def add_song (artist,song)
		@songs << [artist,song]
	end

	def find_songs (artist,song)
		if song == ''
			@songs.select do |x_artist, _|
				x_artist == artist
			end
		else
			@songs.select do |x_artist, x_song|
				(x_artist == artist) && (x_song == song)
			end
		end
	end

end

list_of_songs ||= Spotinatra.new

get '/' do
	@list = list_of_songs.songs
	erb :index  # goes to views folder and looks for the file index.erb (html)
end

post '/' do

	if params[:action] == 'add'
		if list_of_songs.songs.size < 5
			list_of_songs.add_song(params[:artist], params[:song])
		  @list = list_of_songs.songs
			erb :index
		else
			redirect to('/enough')
		end
	end	

	if params[:action] == 'find'		
		@list = list_of_songs.find_songs(params[:artist], params[:song])
		erb :index
	elsif params[:action] == 'delete'
			@list = list_of_songs.find_songs(params[:artist], params[:song])
			@list.each do |song_to_delete| 
				list_of_songs.songs.delete(song_to_delete) #	list_of_songs.songs.delete(@list_found[0])
			end
			@list = list_of_songs.songs
			erb :index
		else
			redirect to('/')
	end
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

