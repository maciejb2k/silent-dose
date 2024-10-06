ActiveAdmin.register Medication do
  permit_params :name, :description, :manufacturer, :form, :meta, :remove_photo, :photo, :unit, :silent_name, :silent_manufacturer, :silent_reminder

  index do
    selectable_column
    column :photo do |medication|
      if medication.photo.attached?
        image_tag(url_for(medication.photo), style: "max-width: 48px; max-height: 48px;")
      else
        image_tag "no-image-placeholder.jpg", size: "48x48"
      end
    end
    column :name
    column :manufacturer
    tag_column :form, interactive: true
    actions
  end

  show do
    attributes_table do
      row :name
      row :manufacturer
      row :form
      row :unit
      row :photo do |medication|
        if medication.photo.attached?
          image_tag(url_for(medication.photo), style: "max-width: 128px; max-height: 128px; margin-bottom: 20px;")
        else
          image_tag "no-image-placeholder.jpg", size: "128x128"
        end
      end
      markdown_row :description
      row :silent_name
      row :silent_manufacturer
      row :silent_reminder
    end
  end

  form do |f|
    f.inputs "Medication Details" do
      f.input :name
      f.input :manufacturer
      f.input :form, include_blank: false
      f.input :unit
      f.input :photo, as: :file,
              hint: object.photo.attached? ?
              image_tag(url_for(object.photo), style: "max-width: 128px; max-height: 128px; margin-top: 20px;") :
              content_tag(:span, "Nie wgrano jeszcze logo.")
      f.input :remove_photo, as: :boolean, label: "Remove photo" if f.object.photo.attached?
      f.input :description, input_html: { rows: 5 }
    end

    f.inputs "Silent" do
      f.input :silent_name
      f.input :silent_manufacturer
      f.input :silent_reminder, input_html: { rows: 5 }
    end

    f.actions
  end
end
