class AddNameToSector < ActiveRecord::Migration
  def change
    add_column :sectors, :quote_id, :string
  end
end
