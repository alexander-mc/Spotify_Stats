class Song < ApplicationRecord
    has_many :song_reports
    has_many :reports, through: :song_reports
    has_many :users, through: :reports
    belongs_to :album
    has_many :song_artists
    has_many :artists, through: :song_artists
    has_many :song_genres
    has_many :genres, through: :song_genres

    scope :order_by_count, -> (options) { group('title').limit(options[:limit]).order('count(title) DESC').pluck('title, sum(ms_played), count(title)') }
    # scope :order_by_ms_played, -> (options) { group('title').limit(options[:limit]).order('sum(ms_played) DESC').pluck('title, sum(ms_played), count(title)') }

    before_destroy :destroy_song_reports

    private

    def destroy_song_reports
        song_reports.in_batches(of: 1000).delete_all
    end

end
