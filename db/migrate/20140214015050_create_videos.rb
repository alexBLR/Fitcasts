class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.string :tubeid
      t.string :duration
      t.string :level
      t.string :equipment
      t.string :type

      t.timestamps
    end
  end
end
