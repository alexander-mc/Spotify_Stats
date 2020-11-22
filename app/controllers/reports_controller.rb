class ReportsController < ApplicationController
    before_action :redirect_if_logged_out, :validate_user_id
    before_action :validate_report_id, only: [:edit, :show]
    after_action :remove_cached_folder, only: [:create, :update]

    def new
        @report = Report.new(user_id: current_user.id)
    end

    def create
        @report = Report.create(report_params)

        if @report.valid?
            @report.load_songs
            redirect_to user_report_path(current_user, @report)
        else
            flash[:report_errors] = @report.errors.full_messages
            render :new
        end
    end

    def index
        @reports = Report.all
    end

    def show



    end

    def edit
        @report = Report.find_by(id: params[:id])
    end

    def update
        @report = Report.find_by(id: params[:id])

        if @report.update(report_params)
            redirect_to user_reports_path(current_user)
        else
            flash[:report_errors] = @report.errors.full_messages
            @original_report_name = Report.find(params[:id]).attachment.identifier
            render :edit
        end
    end

    def destroy
        Report.find_by(id: params[:id]).destroy
        redirect_to user_reports_path(current_user)
    end

    private

    def report_params
        params.require(:report).permit(:report_name, :attachment, :attachment_cache, :user_id)
    end

    def validate_user_id
        if params[:user_id].to_i != current_user.id
            flash[:page_error] = "That page could not be accessed."
            redirect_to user_reports_path(current_user) 
            # You must include the current_user in parentheses.
            # Otherwise, params[:user_id] will not be reset (i.e. will stay incorrect)
        end
    end

    def validate_report_id
        report = current_user.reports.find_by(id: params[:id])
        
        if report.blank?
            flash[:page_error] = "That report does not exist."
            redirect_to user_reports_path(current_user)
        end
    end

    def remove_cached_folder
        if @report.attachment.file
            folder_name = @report.attachment.file.file.split("/")[-2]
            path = Rails.root.to_s + "/public/uploads/tmp/" + folder_name
            FileUtils.rm_rf(path)
        end
    end

end
