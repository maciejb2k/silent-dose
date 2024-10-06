class AddSilentFieldsToMedication < ActiveRecord::Migration[7.2]
  def change
    add_column :medications, :silent_name, :string
    add_column :medications, :silent_manufacturer, :string
    add_column :medications, :silent_reminder, :text

    add_column :daily_reports_medications, :silent_name, :string
    add_column :daily_reports_medications, :silent_manufacturer, :string
    add_column :daily_reports_medications, :silent_reminder, :text
  end
end
