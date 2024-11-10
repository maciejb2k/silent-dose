ActiveAdmin.register ReminderTime do
  menu parent: "Notifications"

  permit_params :user_id, :time

  config.sort_order = "time_asc"

  index do
    column :time do |reminder_time|
      reminder_time.time.strftime("%H:%M")
    end
    actions
  end

  show do
    attributes_table do
      row :time do |reminder_time|
        reminder_time.time.strftime("%H:%M")
      end
    end
  end

  form do |f|
    f.inputs "Reminder Time" do
      f.input :time, as: :time_picker
    end
    f.actions
  end
end
