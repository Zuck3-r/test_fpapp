class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.integer :time_table_id
      t.date :date
      t.integer :planner_id
      t.integer :customer_id
      t.timestamps
    end
    add_index :reservations, %i[planner_id time_table_id date], unique: true
  end
end
