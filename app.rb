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

# DB = PG.connect({:dbname => "record_store"})

get('/results') do
  # @album = Album.search(params[:album_name])
  erb(:search_results)
end

post('/results') do
  name = params[:search]
  # album = Album.new(name, nil)
  # album.save()
  @albums =  Album.search(name)
  erb(:search_results)
end

get('/') do
  @albums = Album.all
  erb(:albums)
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
  binding.pry
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
binding.pry
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
  # album_name = params[:album_name]
  # album = Album.new(:name =>album_name, :id =>nil)
  # album.save()

  @album = Album.find(params[:id].to_i())
  @artist = Artist.find(params[:id].to_i())
  @artist.update({:name => params[:name], :album_name => params[:album_name]})
  @artists = Artist.all
  # @album = Album.find(params[:id].to_i())
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

# get('/artists/new') do
  
# erb(:new_artist)
# end

# get('/') do
#   "This will be our home page. '/' is always the root route in a Sinatra application."
# end

# get('/albums') do
#   "This route will show a list of all albums."
# end

# get('/albums/new') do
#   "This will take us to a page with a form for adding a new album."
# end

# get('/albums/:id') do
#   "This route will show a specific album based on its ID. The value of ID here is #{params[:id]}."
# end

# post('/albums') do
#   "This route will add an album to our list of albums. We can't access this by typing in the URL. In a future lesson, we will use a form that specifies a POST action to reach this route."
# end

# get('/albums/:id/edit') do
#   "This will take us to a page with a form for updating an album with an ID of #{params[:id]}."
# end

# patch('/albums/:id') do
#   "This route will update an album. We can't reach it with a URL. In a future lesson, we will use a form that specifies a PATCH action to reach this route."
# end

# delete('/albums/:id') do
#   "This route will delete an album. We can't reach it with a URL. In a future lesson, we will use a delete button that specifies a DELETE action to reach this route."
# end

# get('/custom_route') do
#   "We can even create custom routes, but we should only do this when needed."
# end

