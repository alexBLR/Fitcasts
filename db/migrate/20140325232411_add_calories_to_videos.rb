class AddCaloriesToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :calories, :integer
  end
end
