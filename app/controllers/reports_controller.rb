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
            @report.load_streaming_history(session)
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
        report = Report.find_by(id: params[:id])

        @start_date = report.song_reports.start_date
        @end_date = report.song_reports.end_date
        
        # TOTAL TIME (including est for missing songs)
        # Missing songs =  2.5min * 1000 ms/min (in 2019, the avg song length is ~ 3min... 2.5min accounts for songs only partially listened to + continued decline in song length)
        time = report.song_reports.total_time + (report.missing_songs * 2.5 * 60 * 1000)
        hours = time / (1000 * 60 * 60) #(ms * sec/min * min/hr)
        minutes = (hours - hours.to_i) * 60
        @total_num_songs = report.songs.count + report.missing_songs
        @total_time = "#{hours.to_i} Hours, #{minutes.round} Minutes"
        # @total_time = Time.at(time/1000).utc.strftime("%d Days, %-H Hours, %-M Minutes")

        # SONGS
        @total_num_uniq_songs = report.songs.uniq{|s| s.id}.count
        @top_songs = report.songs.order_by_count(limit: 10)
        # @top_songs = report.songs.order_by_ms_played(limit: 10)

        # ARTISTS
        @total_num_uniq_artists = report.artists.uniq{|a| a.id}.count
        @top_artists = report.artists.order_by_count(limit: 10)
        # @top_artists = report.artists.order_by_ms_played(limit: 10)

        # ALBUMS
        @total_num_uniq_albums = report.albums.uniq{|a| a.id}.count
        @top_albums = report.albums.order_by_count(limit: 10)
        # @top_albums = report.albums.order_by_ms_played(limit: 10)

        # GENRES
        @total_num_uniq_genres = report.genres.uniq{|g| g.id}.count
        @top_genres = report.genres.order_by_count(limit: 100)
        # @top_genres = report.genres.order_by_ms_played(limit: 10)

    end

    def edit
        @report = Report.find_by(id: params[:id])
    end

    def update
        @report = Report.find_by(id: params[:id])

        if @report.update(report_params)

            if report_params[:attachment].present?
                @report.destroy_song_reports
                @report.missing_songs = 0
                @report.save

                @report.load_streaming_history(session)
            end
            
            redirect_to user_report_path(current_user, @report)
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
            flash[:page_error] = "That page could not be accessed"
            redirect_to user_reports_path(current_user) 
            # You must include the current_user in parentheses.
            # Otherwise, params[:user_id] will not be reset (i.e. will stay incorrect)
        end
    end

    def validate_report_id
        report = current_user.reports.find_by(id: params[:id])
        
        if report.blank?
            flash[:page_error] = "That report does not exist"
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