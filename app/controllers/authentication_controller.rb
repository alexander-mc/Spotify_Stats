class AuthenticationController < ApplicationController

    def callback
        
        # Store callback credentials
        session[:credentials] = request.env['omniauth.auth']
        
        # Update user data
        result = User.update_or_create_Spotify_user_data(session)

        # Raise error for sign ups with existing account linked to Spotify
        if result == "Existing linked account"
            session.delete(:user_id)
            flash[:signup_errors] = Array("This Spotify account is already linked to a user. Please try logging in with the App or through Spotify.")
            redirect_to new_user_path

        else
            redirect_to user_reports_path(session[:user_id])
        end

    end

    def failure
        current_user.destroy if User.signing_in?(current_user)
        session.delete(:user_id)
        redirect_to root_path
    end

end