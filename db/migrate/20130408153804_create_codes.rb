class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.text :code
      t.string :language

      t.timestamps
    end
  end
end
