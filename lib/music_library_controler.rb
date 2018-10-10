
class MusicLibraryController
  attr_accessor :abc_songs
  
  def initialize(path = './db/mp3s')
    importer = MusicImporter.new(path)
    importer.import
  end
  
  def call 
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = gets.chomp
    self.call unless input == "exit"
  end
  
  def list_songs
    songs = Song.all.map {|song| "#{song.name}/#{song.artist.name} - #{song.name} - #{song.genre.name}"}.sort
    songs.each_with_index { |song, index| puts "#{index + 1}. #{song.split("/")[1]}"}
  end
  
  def list_artists
    artists = Artist.all.map {|artist| artist.name}.sort
    artists.each_with_index {|artist_string, index| puts "#{index + 1}. #{artist_string}"}
  end
  
  def list_genres
    genres = Genre.all.map {|genre| genre.name}.sort
    genres.each_with_index {|genre, index| puts "#{index + 1}. #{genre}"}
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets
    if artist = Artist.all.find {|art| art.name == input}
    sorted_songs = artist.songs.sort_by {|song| song.name}
    sorted_songs.each_with_index {|song, index| puts "#{index + 1}. #{song.name} - #{song.genre.name}"}
    else
      # puts "not a match for artist"
     
    end
  end
  
  def list_songs_by_genre
     puts "Please enter the name of a genre:"
     input = gets
     if genre = Genre.all.find {|gen| gen.name == input}
       sorted_songs_by_grenre = genre.songs.sort_by {|song| song.name}
       sorted_songs_by_grenre.each_with_index {|song, index| puts "#{index + 1}. #{song.artist.name} - #{song.name}"}
     end
  end
  
  def play_song
    puts "Which song number would you like to play?"
    self.abc_songs = [] if self.abc_songs == nil 
    self.abc_songs = self.list_songs unless self.abc_songs.length != 0
    input = gets
    index = input.to_i - 1
    
    if index >= 0 && self.abc_songs.length > input.to_i
      song = self.abc_songs[index]
      puts "Playing #{song.name} by #{song.artist}"
      self.abc_songs = []
    end
  end
end



