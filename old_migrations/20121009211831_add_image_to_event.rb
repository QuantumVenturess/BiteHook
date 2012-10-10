class AddImageToEvent < ActiveRecord::Migration
  def change
    add_column :events, :image1, :string
    add_column :events, :image2, :string
    add_column :events, :image3, :string
  end
end
