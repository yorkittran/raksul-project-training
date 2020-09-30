class CreateOsVersions < ActiveRecord::Migration[6.0]
  def change
    create_table :os_versions do |t|
      t.integer :major, null: false
      t.integer :minor, default: 0
      t.integer :patch, default: 0

      t.timestamps
    end
  end
end
