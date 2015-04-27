class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :duration
      t.string :type
      t.string :level

      t.timestamps
    end
  end
end
