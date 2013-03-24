class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.integer :session_id
      t.string :name
      t.text :snippet

      t.timestamps
    end
  end
end
