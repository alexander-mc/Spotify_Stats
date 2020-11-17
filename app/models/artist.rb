class Artist < ApplicationRecord
    has_many :song_artists
    has_many :songs, through: :song_artists
    has_many :albums, through: :songs
    has_many :genres, through: :songs
    has_many :reports, through: :songs

    has_many :users, through: :reports #???
end
