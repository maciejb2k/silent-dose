class CreateDailyReports < ActiveRecord::Migration[7.2]
  def change
    create_table :daily_reports, id: :uuid do |t|
      t.string :title
      t.text :description
      t.date :report_date, null: false
      t.boolean :is_completed, null: false, default: false
      t.boolean :is_template, null: false, default: false

      t.references :user, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
