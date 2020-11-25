class AddColumnsToSongs < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :spotify_id, :string
    add_column :songs, :preview_url, :string
    add_column :songs, :external_url, :string
  end
end
