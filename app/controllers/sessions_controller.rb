class SessionsController < ApplicationController
    skip_before_action :authenticate_user, only: [:new, :create]

    def new
        redirect_to user_reports_path(current_user) if current_user
        @user = User.new
    end

    def create
        # Case insensitive name finder
        user = User.find_by_ci_username(params[:user][:username])

        if user.try(:authenticate, params[:user][:password])
            session[:user_id] = user.id
            redirect_to user_reports_path(user)
        else
            flash[:login_error] = "Sorry, we could not find that username and/or password. Please try again."
            redirect_to login_path
            # Use redirect over render. If user == nil, nil will be passed to the new form builder's user object, resulting in an error.
            # Render would be more appropriate for the signup page, not the login page, since the user instance variable cannot be nil.
            # This is because signing up does not require searching through the database for a matching record.
        end

    end

    def destroy
        session.delete(:user_id)
        redirect_to root_path
    end

end