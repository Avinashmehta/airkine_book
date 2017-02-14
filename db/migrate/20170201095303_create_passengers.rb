class CreatePassengers < ActiveRecord::Migration
  def change
    create_table :passengers do |t|
      t.string :title
      t.string :pass_name
      t.string :category

      t.timestamps null: false
    end
  end
end
