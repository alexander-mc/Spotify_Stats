class User < ApplicationRecord
    has_many :reports
    has_many :songs, through: :reports
    has_many :artists, through: :songs
    has_many :albums, through: :songs
    has_many :genres, through: :songs

    has_secure_password
end
