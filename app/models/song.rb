class Song < ApplicationRecord
    has_many :song_reports
    has_many :reports, through: :song_reports
    has_many :users, through: :reports
    belongs_to :album
    has_many :song_artists
    has_many :artists, through: :song_artists
    has_many :song_genres
    has_many :genres, through: :song_genres
end
