ActiveAdmin.register Medication do
  permit_params :name, :description, :manufacturer, :form, :meta

  index do
    selectable_column
    column :name
    column :manufacturer
    column :form
    actions
  end

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
