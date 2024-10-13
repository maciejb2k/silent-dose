class DropNotNullReportDateFromDailyReports < ActiveRecord::Migration[7.2]
  def change
    change_column_null :daily_reports, :report_date, true
    remove_index :daily_reports, column: [ :user_id, :report_date ]
    add_index :daily_reports, [ :user_id, :report_date ], unique: true, where: "is_template = false"
  end
end
