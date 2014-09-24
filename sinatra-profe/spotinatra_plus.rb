require 'sinatra'
require 'sinatra/reloader'

set :port, 3000

class SongList
  attr_accessor :songs

  def initialize
    @songs = []
  end

  def add_song(name, author)
    @songs << [name, author]
  end

  def has_enough_songs?
    @songs.size >= 10
  end
end

song_list ||= SongList.new

get '/' do
  @song_list = song_list.songs
  erb :index
end

post '/songs/new' do
  # Gets info
  author = params[:author]
  name = params[:name]

  # Stores info
  song_list.add_song(name, author)

  # Redirect to home
  if song_list.has_enough_songs?
    redirect to('/enough')
  else
    redirect to('/')
  end
end

get '/enough' do
  unless song_list.has_enough_songs?
    redirect to('/')
    return
  end

  @song_list = song_list.songs
  erb :enough
end

__END__

Testing it!

curl localhost:3000/
curl -L localhost:3000/songs/new/LedZeppelin/StairwayToHeaven
curl -L localhost:3000/songs/new/FleetwoodMac/Sara
curl -L localhost:3000/songs/new/Beatles/Help
curl -L localhost:3000/songs/new/Falco/RockMeAmadeus
curl -L localhost:3000/songs/new/BeeGees/Tragedy
curl -L localhost:3000/songs/new/PetShopBoys/Paninaro
curl -L localhost:3000/songs/new/SpandauBallet/Gold
curl -L localhost:3000/songs/new/TheB52s/PrivateIdaho
curl -L localhost:3000/songs/new/GiorgioMoroder/Chase
curl -L localhost:3000/songs/new/TheHandsomeFamily/FarFromAnyRoad
