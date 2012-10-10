class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :date
      t.text :info
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :slug

      t.timestamps
    end

    add_index :events, :name
    add_index :events, :date
    add_index :events, :info
    add_index :events, :address_1
    add_index :events, :address_2
    add_index :events, :city
    add_index :events, :state
    add_index :events, :zip_code
  end
end