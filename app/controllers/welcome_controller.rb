class WelcomeController < ApplicationController
    before_action :redirect_if_logged_in, only: [:index]

    def index
    end
end