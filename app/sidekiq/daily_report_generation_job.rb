class DailyReportGenerationJob
  include Sidekiq::Job

  def perform(user_id, daily_report_template_id)
    return if DailyReport.where(user_id: User.find(user_id), report_date: Date.today).exists?

    DailyReports::CreateFromTemplateService.call(daily_report_template_id)
  end
end
