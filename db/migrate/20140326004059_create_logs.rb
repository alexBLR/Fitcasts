class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :sex
      t.integer :age
      t.integer :height
      t.integer :weight
      t.integer :goalweight

      t.timestamps
    end
  end
end
