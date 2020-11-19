class UsersController < ApplicationController

    def new
        redirect_to user_reports_path(current_user) if current_user
        @user = User.new
    end

    def create
        user = User.create(user_params)

        if user.valid?
            redirect_to authentication_path
        else
            flash[:signup_error] = user.errors.full_messages
            @user = user
            render :new
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation)
    end

end
