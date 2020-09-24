class CreateModels < ActiveRecord::Migration[6.0]
  def change
    create_table :models do |t|
      t.string :name, unique: true
      t.references :manufacturer, null: false, foreign_key: true
      t.references :os_name, null: false, foreign_key: true
      t.integer :year_of_manufacture, null: false
      t.datetime :discarded_at

      t.timestamps
      t.index :name
      t.index :discarded_at
    end
  end
end
