class Report < ApplicationRecord
    belongs_to :user
    has_many :song_reports
    has_many :songs, through: :song_reports
    has_many :artists, through: :songs
    has_many :genres, through: :songs
    has_many :albums, through: :songs

    validates :report_name,
              presence: { message: "was not entered" }
              # length: { maximum: 30, too_long: "can only be 1-%{count} characters long" }

    mount_uploader :attachment, AttachmentUploader
    validates :attachment, presence: { message: "was not entered" }, unless: :attachment_errors_exist?

    before_destroy :destroy_song_reports

    def attachment_errors_exist?
        errors[:attachment].present?
    end
    
    # Pull streaming history data that requires authorization
    # user = RSpotify::User.new(session[:credentials])
    
    def load_streaming_history(session)
        
        file = File.read(attachment.file.file)
        streaming_history = JSON.parse(file)
        
        streaming_history.each do |hash|
            
            track_name = hash["trackName"]
            artist_name = hash["artistName"]

            query_tracks = RSpotify::Track.search(track_name)
            
            query_track = query_tracks.select do |t|
              t.artists.any?{|a| a.name == artist_name}
            end

            # Query artists in addition to tracks (WARNING: SLOW)
            # query_tracks = RSpotify::Track.search(track_name)
            # query_artists = RSpotify::Artist.search(artist_name)
            # query_artist_names = query_artists.map{|a| a.name}
            
            # query_track = query_tracks.select do |t|
            #   t.artists.any? do |a|
            #     query_artist_names.include?(a.name)
            #   end
            # end
          
            track = query_track.first

            if track.nil?
                self.missing_songs += 1
                save
                next
            end

            # Convert information from simple to full
            # track.complete!
            # track.album.complete!
            # track.artists.each{|a| a.complete!}

            song = Song.find_by(spotify_id: track.id)
          
            if !song.present?
          
              artist_ids = []
              track.artists.each do |a|
                artist = Artist.find_or_create_by(spotify_id: a.id)
                artist.update(name: a.name)
                artist_ids << artist.id
              end
          
              genre_ids = []
              track.artists.each do |a|
                a.genres.each do |g|
                  genre = Genre.find_or_create_by(name: g)
                  genre_ids << genre.id unless genre_ids.include?(genre.id)
                end
              end
              
              album = Album.find_or_create_by(spotify_id: track.album.id)
              album.update(title: track.album.name, image_url: track.album.images[1]["url"]) # Numbers correspond to image size (0 -> 640x640, 1 -> 300x300, 2 -> 64x64)
          
              song = album.songs.create(spotify_id: track.id, title: track.name, preview_url: track.preview_url, external_url: track.external_urls["spotify"], artist_ids: artist_ids, genre_ids: genre_ids)
            
            end
          
            self.song_reports.create(song_id: song.id, end_time: hash["endTime"].to_datetime, ms_played: hash["msPlayed"])
          
        end
          
    end

    def destroy_song_reports
      song_reports.in_batches(of: 1000).delete_all
    end

end
