class PreviousDayReportGenerationJob
  include Sidekiq::Job

  def perform(user_id)
    user = User.find(user_id)
    previous_day_report = user.daily_reports.reports.find_by(report_date: 1.day.ago)

    return if previous_day_report.blank?
    return if previous_day_report.is_previous_day_report_sent?

    PreviousDayReportMailer.previous_day_report_summary(user, previous_day_report).deliver_now

    previous_day_report.update(is_previous_day_report_sent: true)
  end
end
