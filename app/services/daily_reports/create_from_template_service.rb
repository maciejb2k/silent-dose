class DailyReports::CreateFromTemplateService < ApplicationService
  def initialize(daily_report_id)
    @daily_report_id = daily_report_id
  end

  def call
    daily_report = DailyReport.find(@daily_report_id)

    new_daily_report = daily_report.dup
    new_daily_report.report_date = Date.today
    new_daily_report.title = daily_report.title
    new_daily_report.description = daily_report.description
    new_daily_report.is_template = false
    new_daily_report.is_completed = false
    new_daily_report.save

    daily_report.daily_reports_medications.each do |daily_reports_medication|
      new_daily_reports_medication = daily_reports_medication.dup
      new_daily_reports_medication.daily_report_id = new_daily_report.id
      new_daily_reports_medication.save
    end

    new_daily_report
  end
end
