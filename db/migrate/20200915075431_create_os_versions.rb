class CreateOsVersions < ActiveRecord::Migration[6.0]
  def change
    create_table :os_versions do |t|
      t.integer :major, null: false
      t.integer :minor, null: false
      t.integer :patch, null: false, default: 0

      t.timestamps
    end
  end
end
