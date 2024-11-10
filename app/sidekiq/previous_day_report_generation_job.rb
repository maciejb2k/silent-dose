class PreviousDayReportGenerationJob
  include Sidekiq::Job

  def perform(user_id)
    user = User.find(user_id)
    previous_day_report = user.daily_reports.reports.find_by(report_date: 1.day.ago)

    return if previous_day_report.blank?

    PreviousDayReportMailer.previous_day_report_summary(user, previous_day_report).deliver_now
  end
end
