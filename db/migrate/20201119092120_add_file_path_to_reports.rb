class AddFilePathToReports < ActiveRecord::Migration[6.0]
  def change
    add_column :reports, :file_path, :string
  end
end
