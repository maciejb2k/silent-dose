class PreviousDayReportMailer < ApplicationMailer
  def previous_day_report_summary(user, report)
    @user = user
    @report = report
    @report_summary = generate_report_summary(report)

    mail(
      to: @user.email,
      subject: "[SilentDose] 📄 Podsumowanie z poprzedniego dnia #{report.report_date.strftime('%d-%m-%Y')}"
    )
  end

  private

  def generate_report_summary(report)
    {
      title: report.title,
      description: report.description,
      medications: report.daily_reports_medications.includes(:medication),
      completed: report.is_completed
    }
  end
end
