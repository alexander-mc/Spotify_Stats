class User < ApplicationRecord

    has_many :reports
    has_many :songs, through: :reports
    has_many :artists, through: :songs
    has_many :albums, through: :songs
    has_many :genres, through: :songs

    validates :username,
              presence: { message: "was not entered" },
              format: { with: /\A[a-zA-Z0-9]*\z/, message: "can only contain letters and numbers" },
              uniqueness: { case_sensitive: false, message: "is already taken" }
    
    has_secure_password (options = { validations: false })
    # Set hsp validatons to false in order to customize (see custom validations below)

    validates :password,
              presence: { message: "was not entered" },
              length: { minimum: 6, message: "must contain more than 6 characters"},
              format: { without: /\s/, message: "cannot include spaces"},
              confirmation: { message: "does not match password" }

    scope :find_by_ci_username, -> (username) { where('lower("name") = ?', username.downcase).first }
    #scope :ci_find, lambda { |attribute, value| where("lower(#{attribute}) = ?", value.downcase) }

end
