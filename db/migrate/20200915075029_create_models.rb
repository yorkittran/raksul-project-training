class CreateModels < ActiveRecord::Migration[6.0]
  def change
    create_table :models do |t|
      t.string :name
      t.references :manufacturer, null: false, foreign_key: true
      t.references :os_name, null: false, foreign_key: true
      t.datetime :year_of_manufacture, null: false
      t.boolean :delete_flag, null: false, default: 0

      t.timestamps
    end
    add_index :models, :name
  end
end
