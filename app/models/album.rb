class Album < ApplicationRecord
    has_many :songs
    has_many :genres, through: :songs
    has_many :artists, through: :songs
    has_many :reports, through: :songs
    has_many :users, through: :reports

    scope :order_by_count, -> { group('albums.title').limit(10).order('count(albums.title) DESC').pluck('albums.title, sum(ms_played), count(albums.title)') }
    #scope :order_by_ms_played, -> { group('albums.title').limit(10).order('sum(ms_played) DESC').pluck('albums.title, sum(ms_played), count(albums.title)') }

end
