
class MusicLibraryController
  @@abc_songs = []
  
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
    case input
      when "list songs"
        self.list_songs
      when "list genres"
        self.list_genres
      when 'list artist'
        self.list_songs_by_artist
      when 'list artists'
        self.list_artists
      when 'list genre'
        self.list_songs_by_genre
      when 'play song'
        self.play_song
      when 'exit'
        
      else
        self.call 
    end
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
    if @@abc_songs.length == 0
      @@abc_songs = Song.all.sort_by {|song| song.name}
      list_songs 
    end
    input = gets
    index = input.to_i - 1
    
    if index >= 0 && @@abc_songs.length > input.to_i
      song = @@abc_songs[index]
      puts "Playing #{song.name} by #{song.artist.name}"
      
    end
  end
  
  def self.abc_songs
    @@abc_songs
  end
  
  def self.abc_songs=(array)
    @@abc_songs = array
  end
end



