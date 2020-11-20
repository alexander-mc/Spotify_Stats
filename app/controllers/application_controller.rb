 class ApplicationController < ActionController::Base
    helper_method :current_user
    
    private

    def current_user
        User.find_by(id: session[:user_id])
    end
    
    def redirect_if_logged_out
        redirect_to root_path unless current_user   
    end

    def redirect_if_logged_in
        redirect_to user_reports_path(current_user) if current_user
    end

end