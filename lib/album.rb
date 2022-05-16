class Album
  attr_reader :id
  attr_accessor :name

  

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    # @year = year
    # @genre = genre
    # @artist = artist
  end

  def self.all
    returned_albums = DB.exec("SELECT * FROM albums;")
    albums = []
    returned_albums.each() do |album|
      name = album.fetch("name")
      id = album.fetch("id").to_i
      albums.push(Album.new({:name => name, :id => id}))
    end
    albums
  end

  def save
    result = DB.exec("INSERT INTO albums (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(album_to_compare)
    self.name() == album_to_compare.name()
  end

  def self.clear
    DB.exec("DELETE FROM albums *;")
  end

  def self.find(id)
    album = DB.exec("SELECT * FROM albums WHERE id = #{id};").first
    name = album.fetch("name")
    id = album.fetch("id").to_i
    Album.new({:name => name, :id => id})
  end

  # def update(x)
  #   @name = x
  #   DB.exec("UPDATE albums SET name = '#{@name}' WHERE id = #{@id};")
  # end

  def update(attributes)
    if (attributes.has_key?(:name)) && (attributes.fetch(:name) != nil)
      @name = attributes.fetch(:name)
      DB.exec("UPDATE albums SET name = '#{@name}' WHERE id = #{@id};")
    elsif (attributes.has_key?(:artist_name)) && (attributes.fetch(:artist_name) != nil)
      artist_name = attributes.fetch(:artist_name)
      artist = DB.exec("SELECT * FROM artists WHERE lower(name)='#{artist_name.downcase}';").first
      if artist != nil
        DB.exec("INSERT INTO albums_artists (artist_id, album_id) VALUES (#{artist['id'].to_i}, #{@id});")
      end
    end
  end

  def delete
    DB.exec("DELETE FROM albums WHERE id = #{@id};")
    DB.exec("DELETE FROM songs WHERE album_id = #{@id};")
  end

  def artists
    artists = []
    results = DB.exec("SELECT artist_id FROM albums_artists WHERE album_id = #{@id};")
  results.each() do |result|
    artist_id = result.fetch("artist_id").to_i()
    artist = DB.exec("SELECT * FROM artists WHERE id = #{artist_id};")
    name = artist.first().fetch("name")
    artists.push(Artist.new({:name => name, :id => artist_id}))
  end
    artists
  end
  

  def songs
    Song.find_by_album(self.id)
  end

  def self.search(str)
    # @@albums.find_all { |album| album[1].name.downcase == str.downcase }
     search_results = []
    al = @@albums.find_all { |album| album[1].name.downcase == str.downcase }
      
    search_results.push(al[1])
    
  end
end

# p @@albums.class