class CreateSongArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :song_artists do |t|
      t.integer :song_id
      t.integer :artist_id

      t.timestamps
    end
  end
end
