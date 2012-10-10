class ChangePriceAmountToFloat < ActiveRecord::Migration
  def change
  	change_column :events, :price, :float
  	change_column :payments, :amount, :float
  end
end
