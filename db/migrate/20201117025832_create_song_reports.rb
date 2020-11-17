class CreateSongReports < ActiveRecord::Migration[6.0]
  def change
    create_table :song_reports do |t|
      t.integer :song_id
      t.integer :report_id

      t.timestamps
    end
  end
end
