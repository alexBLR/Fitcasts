class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.integer :user_id
      t.integer :program_id
      t.integer :video_id
      t.integer :day
      t.boolean :complete

      t.timestamps
    end
  end
end
