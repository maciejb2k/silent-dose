class MedicationsReminderJob
  include Sidekiq::Job

  def perform(user_id, reminder_time_id)
    user = User.find(user_id)
    daily_report = user.daily_reports.reports.find_by(report_date: Date.today)

    # Skip if user has no daily report or all medications are taken
    return if daily_report.daily_reports_medications.blank?
    return if daily_report.daily_reports_medications.where(taken: false).empty?

    # Create notification history if not exists, to prevent duplicate notification
    reminder_time = user.reminder_times.find(reminder_time_id)
    start_time = Time.current.change(hour: reminder_time.time.hour, min: reminder_time.time.min)
    end_time = Time.current.change(hour: reminder_time.time.hour, min: reminder_time.time.min, sec: 59, usec: 999999)
    return if user.notification_histories.exists?(sent_at: start_time..end_time)

    # Send reminder email
    DailyReminderMailer.reminder_email(user: user, daily_report: daily_report).deliver_now

    # Create notification history entry
    message = "Send medications reminder to #{user.email} for reminder time #{reminder_time.time.strftime('%H:%M')}"
    user.notification_histories.create!(provider_type: :email, sent_at: Time.current, message: message)
  end
end
