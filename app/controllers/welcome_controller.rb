class WelcomeController < ApplicationController
    skip_before_action :verify_user

    def index
    end
end