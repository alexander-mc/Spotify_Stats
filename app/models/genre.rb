class Genre < ApplicationRecord
    has_many :song_genres
    has_many :songs, through: :song_genres
    has_many :albums, through: :songs
    has_many :artists, through: :songs
    has_many :reports, through: :songs

    has_many :users, through: :reports #???
end
