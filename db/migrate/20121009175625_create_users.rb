class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :image
      t.string :location
      t.integer :facebook_id
      t.string :access_token

      t.timestamps
    end
    add_index :users, :name
    add_index :users, :first_name
    add_index :users, :last_name
    add_index :users, :email
    add_index :users, :location
    add_index :users, :facebook_id, unique: true
    add_index :users, :access_token, unique: true
  end
end
