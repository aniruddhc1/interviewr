class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :session_id
      t.string :interviewer_name
      t.string :interviewee_name
      t.string :company_name
      t.string :position
      t.boolean :active

      t.timestamps
    end
  end
end
