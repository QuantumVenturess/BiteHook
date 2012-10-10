class AddIndexForSlug < ActiveRecord::Migration
  def change
  	add_index :users, :slug
  	add_index :events, :slug
  end
end
