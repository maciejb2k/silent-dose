ActiveAdmin.register_page "Notifications Settings" do
  menu parent: "Notifications", label: "Notifications Settings"

  content title: proc { "Notifications Settings" } do
    active_admin_form_for current_user, url: admin_user_path(current_user), method: :patch do |f|
      tabs do
        tab "Providers" do
          f.input :enable_provider_notifications, label: "Enable Notifications"
        end

        # tab "Discord" do
        #   f.input :enable_discord_notifications
        #   f.input :enable_discord_silent
        #   f.input :discord_notifications_user
        # end

        # tab "Email" do
        #   f.input :enable_email_notifications
        #   f.input :enable_email_silent
        #   f.input :email_notifications_address
        # end

        # tab "SMS" do
        #   f.input :enable_sms_notifications
        #   f.input :enable_sms_silent
        #   f.input :sms_notifications_phone_number
        # end
      end

      f.input :redirect_to, as: :hidden, input_html: { value: admin_notifications_settings_path }

      div style: "margin-top: 20px;" do
        f.actions
      end
    end
  end
end
