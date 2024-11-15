class DailyReportGenerationJob
  include Sidekiq::Job

  def perform
    User.where(enable_auto_create_report: true).find_each do |user|
      report_template = user.daily_reports.templates.find(user.daily_report_id)

      return if report_template.blank? || user.daily_reports.reports.where(report_date: Time.current.to_date).exists?

      DailyReports::CreateFromTemplateService.call(report_template.id)
    end
  end
end
