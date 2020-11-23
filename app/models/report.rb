class Report < ApplicationRecord
    belongs_to :user
    has_many :song_reports
    has_many :songs, through: :song_reports
    has_many :artists, through: :songs
    has_many :genres, through: :songs
    has_many :albums, through: :songs

    validates :report_name, presence: { message: "was not entered" }

    mount_uploader :attachment, AttachmentUploader
    validates :attachment, presence: { message: "was not entered" }, unless: :attachment_errors_exist?

    def attachment_errors_exist?
        errors[:attachment].present?
    end

    def load_streaming_history(session)
        file = File.read(attachment.file.file)
        streaming_history = JSON.parse(file)
        ## TO DO
        binding.pry
        user = RSpotify::User.new(session[:credentials])
        binding.pry
    end

end
