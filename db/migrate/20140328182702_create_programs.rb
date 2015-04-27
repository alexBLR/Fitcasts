class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.integer :user_id
      t.string :name
      t.integer :weeks
      t.integer :time
      t.boolean :fat
      t.boolean :hiit
      t.boolean :core, :default => true
      t.boolean :pilates
      t.boolean :yoga
      t.boolean :stretching, :default => true
      t.boolean :strength
      t.boolean :kettlebell
      t.boolean :barre
      t.boolean :dance
      t.boolean :boxing

      t.timestamps
    end
  end
end
