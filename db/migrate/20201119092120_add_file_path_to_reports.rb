class AddFilePathToReports < ActiveRecord::Migration[6.0]
  def change
    add_column :reports, :attachment, :string
  end
end
