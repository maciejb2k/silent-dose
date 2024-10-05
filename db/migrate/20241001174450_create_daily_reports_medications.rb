class CreateDailyReportsMedications < ActiveRecord::Migration[7.2]
  def change
    create_table :daily_reports_medications, id: :uuid do |t|
      t.integer :dosage, null: false
      t.boolean :taken, null: false, default: false
      t.integer :position, null: false
      t.datetime :intake_time

      t.string :medication_name
      t.string :medication_manufacturer
      t.string :medication_form

      t.references :medication, null: true, foreign_key: true, type: :uuid
      t.references :daily_report, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end

    add_index :daily_reports_medications, %i[daily_report_id position], unique: true
  end
end
