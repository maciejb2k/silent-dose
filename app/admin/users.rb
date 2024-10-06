ActiveAdmin.register User do
  menu false

  permit_params(
    :enable_previous_day_reports,
    :previous_day_report_notification_time,
    :enable_auto_create_report,
    :daily_report_id,
    :enable_provider_notifications,
    :enable_discord_notifications,
    :discord_notifications_user,
    :enable_email_notifications,
    :email_notifications_address,
    :enable_sms_notifications,
    :sms_notifications_phone_number
  )

  controller do
    def update
      @user = current_user
      if @user.update(permitted_params[:user])
        redirect_to params[:user][:redirect_to].to_s || admin_dashboard_path, notice: "Your settings were successfully updated."
      else
        render :edit, alert: "There was an error updating your settings."
      end
    end
  end
end
