class AddDifficultyToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :difficulty, :integer
    add_column :videos, :trainer, :string
    add_column :videos, :bodytype, :string
  end
end
