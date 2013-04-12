class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :openTokID
      t.integer :session_id
      t.integer :interviewee_session_id

      t.timestamps
    end
  end
end
