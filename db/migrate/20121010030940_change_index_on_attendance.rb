class ChangeIndexOnAttendance < ActiveRecord::Migration
  def change
  	remove_index :attendances, :user_id
  	remove_index :attendances, :event_id
  	
  end
end
