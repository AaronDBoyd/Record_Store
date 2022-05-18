require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('pry')
require('./lib/song')
require('./lib/artist')
# require('rb-readline')
also_reload('lib/**/*.rb')
require('pg')
require('./db_access.rb')


get('/results') do
  erb(:search_results)
end

post('/results') do
  name = params[:search]
  @albums =  Album.search(name)
  @artists = Artist.search(name) 
  erb(:search_results)
end

# -change homepage to artists view
get('/') do
  @albums = Album.all
  @artists = Artist.all
  erb(:artists)
end

get ('/albums') do
  @albums = Album.all
  erb(:albums)
  
end

post('/albums') do
  name = params[:album_name]
  album = Album.new(:name =>name, :id =>nil)
  album.save()
  @albums = Album.all
  erb(:albums)
end



get('/albums/new') do
  erb(:new_album)
end

get('/test') do
  @something = "this is a variable"
  erb(:whatever)
end

get('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  erb(:album)
end

get('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

patch('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.update({:name => params[:name], :artist_name => params[:artist_name]})
  @albums = Album.all
  erb(:albums)
end

delete('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  @albums = Album.all
  erb(:albums)
end

# Get the detail for a specific song such as lyrics and songwriters.
get('/albums/:id/songs/:song_id') do
  @song = Song.find(params[:song_id].to_i())
  erb(:song)
end

# Post a new song. After the song is added, Sinatra will route to the view for the album the song belongs to.
post('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  song = Song.new(:name => params[:song_name],:album_id => @album.id,:id => nil)
  song.save()
  erb(:album)
end

# Edit a song and then route back to the album view.
patch('/albums/:id/songs/:song_id') do
  @album = Album.find(params[:id].to_i())
  song = Song.find(params[:song_id].to_i())
  song.update(params[:name], @album.id)
  erb(:album)
end

# Delete a song and then route back to the album view.
delete('/albums/:id/songs/:song_id') do
  song = Song.find(params[:song_id].to_i())
  song.delete
  @album = Album.find(params[:id].to_i())
  erb(:album)
end

get('/artists') do
  @artists = Artist.all
  erb(:artists)
end

get('/artists/new') do
  erb(:new_artist)
  end

get('/artists/:id') do
  @album = Album.find(params[:id].to_i())
  @artist = Artist.find(params[:id].to_i())
  erb(:artist)
end

post('/artists') do
  name = params[:artist_name]
  artist = Artist.new(:name => name, :id => nil)
  artist.save
  @artists = Artist.all
  erb(:artists)
end

patch('/artists/:id') do
  @artist = Artist.find(params[:id].to_i())
  @artist.update({:name => params[:name], :album_name => params[:album_name]})
  @artists = Artist.all
  erb(:artists)
end

post('/artists/:id') do
  album_name = params[:album_name]
  album = Album.new(:name =>album_name, :id =>nil)
  album.save()

  @artist = Artist.find(params[:id].to_i())
  @artist.update({:name => params[:name], :album_name => params[:album_name]})
  erb(:artist)
end

delete('/artists/:id') do
  @artist = Artist.find(params[:id].to_i())
  @artist.delete()
  @artists = Artist.all
  erb(:artists)
end

get('/artists/:id/edit') do
  @artist = Artist.find(params[:id].to_i())
  erb(:edit_artist)
end


