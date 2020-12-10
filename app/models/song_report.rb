class SongReport < ApplicationRecord
    belongs_to :song
    belongs_to :report

    scope :start_date, -> { minimum("end_time").strftime("%^b %Y") }
    scope :end_date, -> { maximum("end_time").strftime("%^b %Y") }
    scope :total_time, -> { sum("ms_played") }

end