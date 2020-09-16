class CreatePhones < ActiveRecord::Migration[6.0]
  def change
    create_table :phones do |t|
      t.references :body_color, null: false, foreign_key: {on_delete: :cascade}
      t.references :memory, null: false, foreign_key: {on_delete: :cascade}
      t.references :os_version, null: false, foreign_key: {on_delete: :cascade}
      t.references :model, null: false, foreign_key: {on_delete: :cascade}
      t.references :user, null: false, foreign_key: {on_delete: :cascade}
      t.boolean :delete_flag, null: false, default: 0

      t.timestamps
    end
  end
end
