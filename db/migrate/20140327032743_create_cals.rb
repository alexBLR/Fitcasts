class CreateCals < ActiveRecord::Migration
  def change
    create_table :cals do |t|
      t.integer :user_id
      t.integer :calburnt

      t.timestamps
    end
  end
end
