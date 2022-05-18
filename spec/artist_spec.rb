require('spec_helper')

describe('#Artist') do
  describe('#update') do
    it("adds an album to an artist") do
      artist = Artist.new({:name => "John Coltrane", :id => nil})
      artist.save()
      album = Album.new({:name => "A Love Supreme", :id => nil})
      album.save()
      artist.update({:album_name => "A Love Supreme"})
      expect(artist.albums).to(eq([album]))
    end
  end

  describe('.all') do
    it('returns an empty array when there are no artists') do
      expect(Artist.all).to(eq([]))
    end
  end

  describe('#save') do
    it('saves an artist') do
      elton = Artist.new(:name => 'Elton John', :id =>nil)
      elton.save()
      pantera = Artist.new(:name =>'Pantera', :id => nil)
      pantera.save()
      expect(Artist.all).to(eq([elton, pantera]))
    end
  end

  describe('#==') do
    it('is the same artist if it has the same attributes as another artist') do
      beatles = Artist.new(:name => 'The Beatles', :id => nil)
      beatles2 = Artist.new(:name => 'The Beatles', :id => nil)
      expect(beatles).to(eq(beatles2))
    end
  end

  describe('.clear') do
    it('clears all artists') do
      slipknot = Artist.new(:name => 'Slipknot', :id => nil)
      slipknot.save
      prince = Artist.new(:name => 'Prince', :id => nil)
      prince.save
      Artist.clear
      expect(Artist.all).to(eq([]))
    end
  end

  describe('.find') do
    it('finds an artist by id') do
      reo = Artist.new(:name => 'REO Speedwagon', :id => nil)
      reo.save
      ozzy = Artist.new(:name => 'Ozzy', :id => nil)
      ozzy.save
      expect(Artist.find(reo.id)).to(eq(reo))
    end
  end

  describe('.search') do
    it("searches for an artist by artist name") do
      artist = Artist.new({:name =>"Lil Porky",:id => nil})
      artist.save
      artist2 = Artist.new({:name =>"Love Supreme", :id => nil})
      artist2.save
      artist3 = Artist.new({:name =>'Giant Steps', :id => nil})
      artist3.save
      expect(Artist.search("por")).to(eq([artist]))  
    end
  end

  describe('#delete') do
    it('deletes an artist by id') do
      artist = Artist.new(:name =>"Giant Steps",:id =>nil)
      artist.save()
      artist2 = Artist.new(:name =>"Naima", :id =>nil)
      artist2.save()
      artist.delete()
      expect(Artist.all).to(eq([artist2]))
    end
  end

  describe('#albums') do
    it('returns all albums related to an artist') do
      album = Album.new(:name => "This is a sweet album", :id => nil)
      album.save
      artist = Artist.new(:name => "Cool Artist Person", :id => nil)
      artist.save
      artist.update(:album_name => "This is a sweet album")
      expect(artist.albums).to(eq([album]))
    end
  end
end
