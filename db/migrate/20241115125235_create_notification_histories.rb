class CreateNotificationHistories < ActiveRecord::Migration[7.2]
  def change
    create_table :notification_histories, id: :uuid do |t|
      t.integer :provider_type, null: false, default: 0
      t.datetime :sent_at, null: false
      t.text :message, null: true
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
