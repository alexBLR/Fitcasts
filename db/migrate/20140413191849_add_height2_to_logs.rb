class AddHeight2ToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :height2, :integer
  end
end
