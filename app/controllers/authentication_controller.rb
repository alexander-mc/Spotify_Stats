class AuthenticationController < ApplicationController

    def callback
        auth_hash = request.env['omniauth.auth']

        user = User.find_or_create_by(spotify_id: auth_hash[:uid])
        # If feature is added to edit user info, you can change the above to a block

        user.spotify_username = auth_hash[:info][:display_name]
        user.email = auth_hash[:info][:email]
        user.save(validate: false)
        
        session[:user_id] = user.id
        redirect_to user_reports_path(user)
    end

    def failure
        User.undo_signup
        redirect_to root_path
    end

end