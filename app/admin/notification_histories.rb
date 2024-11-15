ActiveAdmin.register NotificationHistory do
  menu parent: "Notifications"

  permit_params :provider_type, :sent_at, :message, :user_id

  config.sort_order = "sent_at_desc"

  actions :all, except: [ :new, :edit, :destroy ]

  filter :created_at
  filter :updated_at

  index do
    selectable_column
    id_column
    column :provider_type
    column :sent_at
    actions
  end

  show do
    attributes_table do
      row :provider_type
      row :sent_at
      row :message
      row :created_at
      row :updated_at
    end
  end
end
