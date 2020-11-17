class SongReport < ApplicationRecord
    belongs_to :song
    belongs_to :report
end
