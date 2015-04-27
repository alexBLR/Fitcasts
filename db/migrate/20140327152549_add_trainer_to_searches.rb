class AddTrainerToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :trainer, :string
    add_column :searches, :bodytype, :string
    add_column :searches, :difficulty, :integer
    add_column :searches, :calories, :integer
  end
end
