class CreateIntervieweeSessions < ActiveRecord::Migration
  def change
    create_table :interviewee_sessions do |t|
      t.string :random
      t.string :name
      t.timestamps
    end
  end
end
