class AddColumnToArtists < ActiveRecord::Migration[6.0]
  def change
    add_column :artists, :spotify_id, :string
  end
end
