ActiveAdmin.register User do
  actions :index, :show

  permit_params(
    :enable_previous_day_reports,
    :previous_day_report_notification_time,
    :enable_auto_create_report,
    :daily_report_id,
    :enable_provider_notifications,
    :enable_discord_notifications,
    :enable_discord_silent,
    :discord_notifications_user,
    :enable_email_notifications,
    :enable_email_silent,
    :email_notifications_address,
    :enable_sms_notifications,
    :enable_sms_silent,
    :sms_notifications_phone_number
  )

  controller do
    def update
      @user = current_user
      if @user.update(permitted_params[:user])
        redirect_to params[:user][:redirect_to].to_s || admin_dashboard_path, notice: "Your settings were successfully updated."
      else
        flash[:error] = @user.errors.full_messages.join(", ")
        redirect_back fallback_location: params[:user][:redirect_to].to_s
      end
    end
  end

  index do
    id_column
    column :email
    column :role
    actions
  end

  show do
    attributes_table do
      row :id
      row :email
      row :role
    end
  end
end
