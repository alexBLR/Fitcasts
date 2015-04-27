class ChangeFotmatTable < ActiveRecord::Migration
  def change
  	change_column :searches, :duration, 'integer USING CAST(duration AS integer)'
    change_column :videos, :duration, 'integer USING CAST(duration AS integer)'
  	
  end
end
