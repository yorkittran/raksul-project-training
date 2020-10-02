class CreateInventories < ActiveRecord::Migration[6.0]
  def change
    create_table :inventories do |t|
      t.references :phone, null: false, foreign_key: true
      t.decimal :price, null: false
      t.integer :quantity, null: false
      t.datetime :discarded_at

      t.timestamps
      t.index :discarded_at
    end
  end
end
