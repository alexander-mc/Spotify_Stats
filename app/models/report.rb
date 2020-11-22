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

    def load_songs
        file = File.read(attachment.file.file)
        data_hash = JSON.parse(file)
        binding.pry
    end

end
