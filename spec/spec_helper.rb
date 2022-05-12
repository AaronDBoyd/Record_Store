require 'rspec'
require 'pg'
require 'album'
require 'artist'
require 'song'
require 'pry'
require './test_db_access.rb'

# DB = PG.connect({:dbname => 'record_store'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM albums *;")
    DB.exec("DELETE FROM songs *;")
    DB.exec("DELETE FROM artists *;")
    DB.exec("DELETE FROM albums_artists")
  end
end