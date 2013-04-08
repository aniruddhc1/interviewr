class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :random
      t.string :interviewer
      t.string :company

      t.timestamps
    end
  end
end
