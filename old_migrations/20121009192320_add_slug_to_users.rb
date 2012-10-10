class AddSlugToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :slug, :string
  	add_column :users, :last_in, :datetime
  	add_column :users, :in_count, :integer

  	add_index :users, :last_in
  	add_index :users, :in_count
  end
end
