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
              confirmation: { message: "did not match password" }

    scope :find_by_ci_username, -> (username) { where('lower("username") = ?', username.downcase).first }
    #scope :ci_find, lambda { |attribute, value| where("lower(#{attribute}) = ?", value.downcase) }

    def self.update_or_create_Spotify_user_data(session)
    
        auth_hash = session[:credentials]

        logged_in_user = User.find_by(id: session[:user_id])
        already_existing_user = User.find_by(spotify_uid: auth_hash[:uid])

        # Sign ups that already have an account due to a prior log in with Spotify
        if signing_up?(logged_in_user) && already_existing_user.present?

            # Username already exists
            if already_existing_user.username?
                logged_in_user.destroy
                return "Existing linked account"

            # Username does not exist
            else
                already_existing_user.update(username: logged_in_user.username, password_digest: logged_in_user.password_digest)
                already_existing_user.save(validate: false)
                session[:user_id] = already_existing_user.id
                logged_in_user.destroy
            end

        # Log ins through App or Spotify + new sign ups (i.e. user has never logged in with Spotify)
        else
            current_user = User.find_or_create_by(spotify_uid: auth_hash[:uid])
            current_user.spotify_username = auth_hash[:info][:display_name]
            current_user.spotify_email = auth_hash[:info][:email]
            current_user.save(validate: false)

            session[:user_id] = current_user.id
        end

    end

    def self.signing_up?(user)
        user.spotify_uid.blank? if user.present?
    end

end