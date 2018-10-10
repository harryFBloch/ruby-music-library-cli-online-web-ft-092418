class Artist 
  attr_accessor :name, :songs
  extend EasyModule::ClassMethods
  extend Concerns::Findable
  include EasyModule::InstanceMethods
  @@all = []
  
  def initialize(name)
    super
  end
  
  def self.all 
    @@all 
  end
  
  def genres
    return_array = self.songs.map {|song| song.genre}.uniq
  end
  
   def add_song(song)
      song.artist = self unless song.artist
      self.songs << song unless self.songs.include?(song)
      self.genres << song.genre if song.genre.class == Genre
   end
   
end