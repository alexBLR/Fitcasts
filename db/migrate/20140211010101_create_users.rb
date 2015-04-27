class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :name
      t.string   :email
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :password_digest
      t.string   :remember_token
      t.boolean  :admin, :default => true
      t.integer  :invitation_id
      t.integer  :invitation_limit
      t.string   :token

      t.timestamps
    end
  end
end