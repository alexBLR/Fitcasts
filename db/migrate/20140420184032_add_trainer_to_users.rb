class AddTrainerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :trainer, :boolean, :default => false
    add_column :users, :trainer_name, :string
  end
end
