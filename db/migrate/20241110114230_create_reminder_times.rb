class CreateReminderTimes < ActiveRecord::Migration[7.2]
  def change
    create_table :reminder_times, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.datetime :time

      t.timestamps
    end
  end
end
