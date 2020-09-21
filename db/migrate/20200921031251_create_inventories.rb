class CreateInventories < ActiveRecord::Migration[6.0]
  def change
    create_table :inventories do |t|
      t.references :phone, null: false, foreign_key: true
      t.decimal :price
      t.integer :quantity

      t.timestamps
      t.index [:phone_id, :price], unique: true
    end
  end
end
