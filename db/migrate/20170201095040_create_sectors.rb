class CreateSectors < ActiveRecord::Migration
  def change
    create_table :sectors do |t|
      t.string :flight_name
      t.integer :airline_no
      t.string :departure
      t.string :arrival
      t.integer :base_fare

      t.timestamps null: false
    end
  end
end
