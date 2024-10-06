ActiveAdmin.register Provider do
  permit_params :name, :provider_type, :description, config: {}

  json_editor

  index do
    tag_column :provider_type
    column :name
    column :description
    actions
  end

  show do
    attributes_table do
      row :name
      markdown_row :description
      tag_row :provider_type
      row :config do |provider|
        tag.pre JSON.pretty_generate(provider.config)
      end
    end
  end

  form do |f|
    f.inputs "Provider Configuration" do
      f.input :name
      f.input :provider_type
      f.input :config, as: :jsonb
      f.input :description, input_html: { rows: 3 }
    end
    f.actions
  end
end
