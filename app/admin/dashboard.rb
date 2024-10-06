ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content do
    @daily_reports = policy_scope(DailyReport).where(is_template: false).all
    render partial: "admin/calendar", locals: { daily_reports: @daily_reports }
  end
end
