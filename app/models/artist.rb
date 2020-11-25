class Artist < ApplicationRecord
    has_many :song_artists
    has_many :songs, through: :song_artists
    has_many :albums, through: :songs
    has_many :genres, through: :songs
    has_many :reports, through: :songs
    has_many :users, through: :reports

    scope :order_by_count, -> { group('name').limit(10).order('count(name) DESC').pluck('name, sum(ms_played), count(name)') }
    #scope :order_by_ms_played, -> { group('name').limit(10).order('sum(ms_played) DESC').pluck('name, sum(ms_played), count(name)') }

end
