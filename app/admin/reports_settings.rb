ActiveAdmin.register_page "Reports Settings" do
  menu parent: "Notifications", label: "Reports Settings"

  content title: proc { "Reports Settings" } do
    active_admin_form_for current_user, url: admin_user_path(current_user), method: :patch do |f|
      tabs do
        tab "Auto create report from template" do
          f.input :enable_auto_create_report
          f.input :daily_report_id, as: :select, collection: policy_scope(DailyReport).templates
        end

        tab "Previous day report" do
          f.input :enable_previous_day_reports
          f.input :previous_day_report_notification_time, as: :time_picker
        end
      end

      f.input :redirect_to, as: :hidden, input_html: { value: admin_reports_settings_path }

      div style: "margin-top: 20px;" do
        f.actions
      end
    end
  end
end
