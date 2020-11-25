class AddColumnsToAlbums < ActiveRecord::Migration[6.0]
  def change
    add_column :albums, :spotify_id, :string
    add_column :albums, :image_url, :string
  end
end
