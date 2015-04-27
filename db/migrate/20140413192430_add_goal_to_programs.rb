class AddGoalToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :goal, :string
  end
end
