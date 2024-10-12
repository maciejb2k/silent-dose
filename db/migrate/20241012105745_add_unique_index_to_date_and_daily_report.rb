class AddUniqueIndexToDateAndDailyReport < ActiveRecord::Migration[7.2]
  def change
    add_index :daily_reports, %i[user_id report_date], unique: true
  end
end
