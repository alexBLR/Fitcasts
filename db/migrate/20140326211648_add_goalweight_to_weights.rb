class AddGoalweightToWeights < ActiveRecord::Migration
  def change
    add_column :weights, :goalweight, :integer
  end
end
