class CreateMemories < ActiveRecord::Migration[6.0]
  def change
    create_table :memories do |t|
      t.integer :amount, null: false, unique: true
      t.string :display_name, null: false, unique: true

      t.timestamps
    end
  end
end
