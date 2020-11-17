class SongArtist < ApplicationRecord
    belongs_to :song
    belongs_to :artist
end
