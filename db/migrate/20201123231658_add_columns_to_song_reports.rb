class AddColumnsToSongReports < ActiveRecord::Migration[6.0]
  def change
    add_column :song_reports, :ms_played, :integer
    add_column :song_reports, :end_time, :datetime
  end
end
