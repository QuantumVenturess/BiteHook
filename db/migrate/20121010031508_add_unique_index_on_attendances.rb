class AddUniqueIndexOnAttendances < ActiveRecord::Migration
  def change
  	add_index :attendances, [:user_id, :event_id], unique: true
  end
end
