class AddPreviosDayReportSentToDailyReport < ActiveRecord::Migration[7.2]
  def change
    add_column :daily_reports, :is_previous_day_report_sent, :boolean, default: false, null: false
  end
end
