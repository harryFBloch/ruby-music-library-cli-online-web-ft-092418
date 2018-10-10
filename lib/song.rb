class Song 
  attr_accessor :name, :artist, :genre
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    self.name = name 
    self.artist = artist if artist.class == Artist
    self.genre = genre if genre.class == Genre
     if genre.class == Genre && !self.artist.genres.include?(genre)
       self.artist.genres << genre
     end
  end
  
  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end
  
   def self.all 
    @@all
   end
  
  def self.destroy_all 
    @@all.clear
  end
  
  def save
    @@all << self
  end
  
  def artist=(artist)
    @artist = artist
    self.artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    @genre.songs << self unless genre.songs.include?(self)
  end
  
  def self.find_by_name(name)
    @@all.find {|song| song.name == name}
  end
  
  def self.find_or_create_by_name(name)
    found = self.find_by_name(name)
    if found.class == Song
      found
    else
      Song.create(name)
    end
  end
  
  def self.new_from_filename(filename)
    name = filename.split(" - ")[1]
    artist = Artist.find_or_create_by_name(filename.split(" - ")[0])
    genre = Genre.find_or_create_by_name(filename.split(" - ")[2].gsub(".mp3",""))
    song = Song.new(name, artist, genre)
    song.save
    song
    # song.artist = Artist.find_or_create_by_name(artist)
    # song.artist.songs << song
    # song
  end
  
  def self.create_from_filename(filename)
    self.new_from_filename(filename)
  end
end