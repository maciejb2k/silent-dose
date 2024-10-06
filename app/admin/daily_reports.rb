ActiveAdmin.register DailyReport do
  menu parent: "Daily Reports", label: "Reports", priority: 1

  config.sort_order = "report_date_desc"

  permit_params :report_date, :user_id, :title, :description, :is_completed, :is_template,
                daily_reports_medications_attributes: [ :id, :medication_id, :dosage, :user_id, :position, :taken, :_destroy ]

  action_item :medications, only: %i[show], priority: 1 do
    link_to "Medications", admin_daily_report_daily_reports_medications_path(daily_report)
  end

  action_item :create_from_template, only: %i[show], priority: 2, if: -> { daily_report.is_template } do
    link_to "Create Report From Template", create_report_from_template_admin_daily_report_path(daily_report), method: :post
  end

  member_action :create_report_from_template, method: :post do
    new_daily_report = CreateDailyReportFromTemplateService.new(daily_report_id: params[:id]).call
    redirect_to admin_daily_report_path(new_daily_report)
  end

  scope :reports, default: true
  scope :templates

  filter :report_date
  filter :user
  filter :medications

  index do
    column :report_date
    column :title do |daily_report|
      truncate(daily_report.title, length: 50)
    end
    column :description do |daily_report|
      truncate(daily_report.description, length: 50)
    end
    actions do |daily_report|
      if daily_report.is_template
        link_to "Create Report", create_report_from_template_admin_daily_report_path(daily_report),
                                 method: :post, class: "member_link", style: "margin-left: 10px;"
      end
    end
  end

  show do
    attributes_table do
      row :report_date
      row :title
      markdown_row :description
    end

    panel "Medications" do
      table_for daily_report.daily_reports_medications.order(:position) do
        column :photo do |daily_report_medication|
          if daily_report_medication&.medication&.photo&.attached?
            image_tag(url_for(daily_report_medication.medication.photo), style: "max-width: 48px; max-height: 48px;")
          else
            image_tag "no-image-placeholder.jpg", size: "48x48"
          end
        end
        column "Medication" do |daily_report_medication|
          if daily_report_medication.medication.present?
            link_to daily_report_medication.medication.name, admin_medication_path(daily_report_medication.medication)
          else
            "#{daily_report_medication.medication_name} (Deleted)"
          end
        end
        column :dosage
        column :intake_time
        toggle_bool_column :taken
      end
    end
  end

  form do |f|
    f.inputs "Daily Report Details" do
      f.input :report_date, as: :datepicker, input_html: { value: Date.today }
      f.input :title
      f.input :description, input_html: { rows: 5 }
      f.input :is_template, as: :boolean
      unless f.object.new_record?
        f.input :is_completed, as: :boolean
      end
    end

    f.inputs "Medications" do
      f.has_many :daily_reports_medications, allow_destroy: true, new_record: true do |m|
        if m.object.new_record? || m.object.medication.present?
          m.input :medication, collection: policy_scope(Medication).map { |med| [ med.name, med.id ] }
        else
          m.input :medication_name, input_html: { disabled: true, value: m.object.medication_name }, label: "Medication (Deleted)"
          m.input :medication_manufacturer, input_html: { disabled: true, value: m.object.medication_manufacturer }, label: "Manufacturer"
        end

        m.input :dosage
        m.input :intake_time, as: :time_picker
        m.input :taken, as: :boolean
        m.input :user_id, as: :hidden, input_html: { value: current_user.id }
      end
    end

    f.actions
  end
end
