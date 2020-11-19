require 'rspotify/oauth'

scope = "user-read-recently-played
        user-read-email
        playlist-modify-public
        user-library-read
        user-library-modify
        user-modify-playback-state
        app-remote-control
        streaming"

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :spotify, ENV['SPOTIFY_ID'], ENV['SPOTIFY_SECRET'], scope: scope
end