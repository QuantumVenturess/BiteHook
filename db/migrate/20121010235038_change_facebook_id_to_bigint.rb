class ChangeFacebookIdToBigint < ActiveRecord::Migration
  def change
  	change_column :users, :facebook_id, :bigint
  end
end
