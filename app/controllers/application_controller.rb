 class ApplicationController < ActionController::Base
    before_action :verify_user

    private

    def verify_user
        redirect_to root_path unless current_user
    end
    
    def current_user
        User.find_by(id: session[:user_id])
    end

end