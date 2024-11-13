class MedicationsReminderJob
  include Sidekiq::Job

  def perform(user_id)
    user = User.find(user_id)
    daily_report = user.daily_reports.reports.find_by(report_date: Date.today)

    return if daily_report.daily_reports_medications.blank?
    return if daily_report.daily_reports_medications.where(taken: false).empty?

    DailyReminderMailer.reminder_email(user: user, daily_report: daily_report).deliver_now
  end
end
