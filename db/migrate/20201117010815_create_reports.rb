class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.string :report_name
      t.integer :user_id

      t.timestamps
    end
  end
end
