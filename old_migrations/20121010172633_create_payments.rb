class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.integer :event_id
      t.integer :amount
      t.string :transaction_id
      t.string :description

      t.timestamps
    end

    add_index :payments, [:user_id, :event_id]
    add_index :payments, :amount
    add_index :payments, :transaction_id
    add_index :payments, :description
  end
end
