class Song < ApplicationRecord
    has_many :song_reports
    has_many :reports, through: :song_reports
    has_many :users, through: :reports
    belongs_to :album
    has_many :song_artists
    has_many :artists, through: :song_artists
    has_many :song_genres
    has_many :genres, through: :song_genres

    scope :order_by_count, -> { group('title').limit(10).order('count(title) DESC').pluck('title, sum(ms_played), count(title)') }
    #scope :order_by_ms_played, -> { group('title').limit(10).order('sum(ms_played) DESC').pluck('title, sum(ms_played), count(title)') }

end
