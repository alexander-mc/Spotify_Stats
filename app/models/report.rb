class Report < ApplicationRecord
    belongs_to :user
    has_many :song_reports
    has_many :songs, through: :song_reports
    has_many :artists, through: :songs
    has_many :genres, through: :songs
    has_many :albums, through: :songs

    validates :name, presence: { message: "was not entered" }
    validates :file_path, presence: { message: "was not entered" }
    
end
