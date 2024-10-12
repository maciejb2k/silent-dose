ActiveAdmin.register DailyReports::Medication do
  config.sort_order = "position_asc"
  config.paginate   = false

  belongs_to :daily_report

  permit_params :medication_id, :dosage, :user_id, :position, :taken, :daily_report_id, :intake_time, :unit, :medication_name, :medication_manufacturer, :medication_form

  sortable

  index do
    sortable_handle_column
    column "Medication" do |daily_report_medication|
      if daily_report_medication.medication.present?
        link_to daily_report_medication.medication.name, admin_medication_path(daily_report_medication.medication)
      else
        "#{daily_report_medication.medication_name} (Deleted)"
      end
    end
    column :dosage
    column :intake_time
    column :position
    toggle_bool_column :taken
    actions
  end

  form do |f|
    f.inputs do
      if f.object.medication.present? || f.object.new_record?
        f.input :medication, collection: policy_scope(Medication).map { |med| [ med.name, med.id ] }
      else
        f.input :medication_name, input_html: { disabled: true, value: f.object.medication_name }, label: "Medication (Deleted)"
        f.input :medication_manufacturer, input_html: { disabled: true, value: f.object.medication_manufacturer }, label: "Manufacturer"
      end
      f.input :dosage
      f.input :intake_time, as: :time_picker
      f.input :taken, as: :boolean
    end

    f.actions
  end
end
