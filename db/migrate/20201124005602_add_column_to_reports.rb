class AddColumnToReports < ActiveRecord::Migration[6.0]
  def change
    add_column :reports, :missing_songs, :integer, default: 0
  end
end
