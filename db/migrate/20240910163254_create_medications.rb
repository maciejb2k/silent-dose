class CreateMedications < ActiveRecord::Migration[7.2]
  def change
    create_table :medications, id: :uuid do |t|
      t.string :name, null: false
      t.text :description
      t.string :manufacturer, null: false
      t.integer :form, default: 0, null: false
      t.string :unit
      t.jsonb :meta, default: {}, null: false
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
