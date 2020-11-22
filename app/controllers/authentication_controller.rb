class AuthenticationController < ApplicationController

    def callback
        binding.pry
        
        # Store callback credentials
        session[:credentials] = request.env['omniauth.auth']
        result = User.create_or_update_with_Spotify_user_data(session)
        # auth_hash = session[:credentials]

        # logged_in_user = User.find_by(id: session[:user_id])
        # already_existing_user = User.find_by(spotify_uid: auth_hash[:uid])
        # signing_in = logged_in_user.spotify_uid.blank? if logged_in_user
        # user_already_exists = !!already_existing_user

        # if signing_in && user_already_exists
        #     binding.pry
        #     already_existing_user.update(username: logged_in_user.username, password_digest: logged_in_user.password_digest)
        #     already_existing_user.save(validate: false)

        #     session[:user_id] = already_existing_user.id
        #     logged_in_user.destroy
        # else
        #     current_user = User.find_or_create_by(spotify_uid: auth_hash[:uid])
        #     current_user.spotify_username = auth_hash[:info][:display_name]
        #     current_user.spotify_email = auth_hash[:info][:email]
        #     current_user.save(validate: false)

        #     session[:user_id] = current_user.id
        # end
        binding.pry
        if result.is_a? String
            flash[:page_error] = result
        end

        redirect_to user_reports_path(session[:user_id])
    end

    def failure
        current_user.destroy if User.signing_in?(current_user)
        # if current_user
        #     binding.pry

        #     current_user.destroy if current_user.spotify_uid.blank?

        #     binding.pry
        # end
        # binding.pry
        session.delete(:user_id)
        redirect_to root_path
    end

    # def signing_in?
    #     logged_in_user.spotify_uid.blank? if logged_in_user
    # end

    # def user_already_exists?
    #     !!already_existing_user
    # end

end