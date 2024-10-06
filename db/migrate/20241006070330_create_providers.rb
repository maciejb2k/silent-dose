class CreateProviders < ActiveRecord::Migration[7.2]
  def change
    create_table :providers, id: :uuid do |t|
      t.string :name, null: false
      t.text :description
      t.integer :provider_type, null: false, default: 0
      t.jsonb :config, null: false, default: {}

      t.timestamps
    end

    add_index :providers, :provider_type, unique: true
  end
end
