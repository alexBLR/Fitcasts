class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :searches, :type, :fitnesstype
  	rename_column :videos, :type, :fitnesstype
  end
end
