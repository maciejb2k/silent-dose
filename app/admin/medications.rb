ActiveAdmin.register Medication do
  menu parent: "Storage", priority: 1

  permit_params :name, :description, :manufacturer, :form, :meta

  show do
    attributes_table do
      row :name
      row :manufacturer
      row :form
      row :description
    end
  end

  form do |f|
    f.inputs "Medication Details" do
      f.input :name
      f.input :manufacturer
      f.input :form, include_blank: false
      f.input :description
    end
    f.actions
  end
end
