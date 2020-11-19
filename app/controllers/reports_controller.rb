class ReportsController < ApplicationController
    before_action :authenticate_user

    def new
        @report = Report.new
    end

    def create
        binding.pry
    end

    def index
    end

    def show
    end

    def edit
    end

    def udpate
    end

    def destroy
    end

end
