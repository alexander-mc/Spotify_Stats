class AuthenticationController < ApplicationController

    def callback
        binding.pry
        # Store callback credentials
        session[:credentials] = request.env['omniauth.auth']
        auth_hash = session[:credentials]
        #current_user = User.find_by(id: session[:user_id])

        if current_user # is logged in
            original_user = User.find_by(spotify_uid: auth_hash[:uid])
            if current_user.spotify_uid.blank? && original_user
                original_user.update(username: current_user.username, password_digest: current_user.password_digest)
                original_user.save(validate: false)
                current_user.destroy
                session[:user_id] = original_user.id

                binding.pry
            else
                binding.pry
                current_user = User.find_by(id: session[:user_id])
                current_user.spotify_username = auth_hash[:info][:display_name]
                current_user.spotify_uid = auth_hash[:uid]
                current_user.spotify_email = auth_hash[:info][:email]
                current_user.save(validate: false)

                binding.pry
            end
        else
            binding.pry
            
            current_user = User.find_or_create_by(spotify_uid: auth_hash[:uid])

            # Create or update user data from Spotify
            # If feature is added to edit user info, you can change to a block
            current_user.spotify_username = auth_hash[:info][:display_name]
            current_user.spotify_email = auth_hash[:info][:email]
            current_user.save(validate: false)
            
            session[:user_id] = current_user.id

            binding.pry
        end

        binding.pry
        redirect_to user_reports_path(session[:user_id])
    end

    def failure
        if current_user
            binding.pry

            current_user.destroy if current_user.spotify_uid.blank?

            binding.pry
        end
        binding.pry
        session.delete(:user_id)
        redirect_to root_path
    end

end