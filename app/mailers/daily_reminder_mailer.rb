class DailyReminderMailer < ApplicationMailer
  default from: "no-reply@silentdose.com"

  def reminder_email(user:, daily_report:)
    @user = user
    @daily_report = daily_report
    @not_taken_medications = not_taken_medications

    mail(
      to: @user.email,
      subject: "Daily Reminder"
    )
  end

  private

  def not_taken_medications
    @daily_report.daily_reports_medications.includes(:medication).where(taken: false)
  end
end
