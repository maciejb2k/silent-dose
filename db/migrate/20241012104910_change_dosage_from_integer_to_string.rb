class ChangeDosageFromIntegerToString < ActiveRecord::Migration[7.2]
  def change
    change_column :daily_reports_medications, :dosage, :string, null: false, default: ""
  end
end
