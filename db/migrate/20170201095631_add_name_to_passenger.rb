class AddNameToPassenger < ActiveRecord::Migration
  def change
    add_column :passengers, :quote_id, :string
  end
end
