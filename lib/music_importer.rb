class MusicImporter
  attr_accessor :path
  
  def initialize(path)
    self.path = path
  end
  
  def import
    self.files.each{ |filename| Song.create_from_filename(filename) }
  end
  
  def files 
    Dir[@path+"/*.mp3"].map { |file| file.split("/").last }
  end
  
end