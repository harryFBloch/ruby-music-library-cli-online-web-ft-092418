class Genre 
  attr_accessor :name, :songs
  extend EasyModule::ClassMethods
  extend Concerns::Findable
  include EasyModule::InstanceMethods
  @@all = []
  
  
  def self.all 
    @@all 
  end
  
  def artists
    return_array = self.songs.map {|song| song.artist}.uniq
  end
end
 