class CreateFarequotes < ActiveRecord::Migration
  def change
    create_table :farequotes do |t|
      t.string :name
      t.string :dep
      t.string :arr
      t.float :set_tax
      t.float :kri_kal_cess
      t.float :swc_bha_cess
      t.float :cute_fee
      t.float :fare
      t.string :quote_id
      t.string :category

      t.timestamps null: false
    end
  end
end
