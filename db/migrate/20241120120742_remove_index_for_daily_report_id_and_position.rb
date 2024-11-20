class RemoveIndexForDailyReportIdAndPosition < ActiveRecord::Migration[7.2]
  def up
    remove_index :daily_reports_medications, column: %i[daily_report_id position]
  end

  def down
    add_index :daily_reports_medications, %i[daily_report_id position], unique: true
  end
end
