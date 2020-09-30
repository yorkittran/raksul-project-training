class CreatePhones < ActiveRecord::Migration[6.0]
  def change
    create_table :phones do |t|
      t.references :body_color, null: false, foreign_key: true
      t.references :memory, null: false, foreign_key: true
      t.references :os_version, null: false, foreign_key: true
      t.references :model, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :discarded_at

      t.timestamps
      t.index :discarded_at
      t.index [:body_color_id, :memory_id, :os_version_id, :model_id], name: 'uniq_reference', unique: true
    end
  end
end
