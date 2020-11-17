class Album < ApplicationRecord
    has_many :songs
    has_many :genres, through: :songs
    has_many :artists, through: :songs
    has_many :reports, through: :songs

    has_many :users, through: :reports # ???
end
