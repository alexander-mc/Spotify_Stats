class UsersController < ApplicationController
    skip_before_action :verify_user, only: [:new, :create]

    def new
        redirect_to user_reports_path(current_user) if current_user
        @user = User.new
    end

    def create
        @user = User.create(user_params)

        if @user.valid?
            session[:user_id] = @user.id
            redirect_to user_reports_path(@user)
        else
            flash[:signup_error] = @user.errors.full_messages
            render :new
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation)
    end

end
