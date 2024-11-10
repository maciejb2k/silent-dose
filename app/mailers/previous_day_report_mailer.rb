class PreviousDayReportMailer < ApplicationMailer
  default from: "no-reply@silentdose.com"

  def previous_day_report_summary(user, report)
    @user = user
    @report = report
    @report_summary = generate_report_summary(report)

    mail(
      to: @user.email,
      subject: "Your Daily Report Summary for #{report.report_date.strftime('%B %d, %Y')}"
    )
  end

  private

  def generate_report_summary(report)
    {
      title: report.title,
      description: report.description,
      medications: report.daily_reports_medications.includes(:medication).map do |med|
        { name: med.medication.name, taken: med.taken? }
      end,
      completed: report.is_completed
    }
  end
end
