class CreateOsNames < ActiveRecord::Migration[6.0]
  def change
    create_table :os_names do |t|
      t.string :name, null: false, unique: true

      t.timestamps
      t.index :name, name: 'uniq_reference', unique: true
    end
  end
end
