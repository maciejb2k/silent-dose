class DailyReports::MedicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_medication, only: [ :update ]

  def update
    @medication.update(medication_params)

    @daily_report = @medication.daily_report
    @total_medications = @daily_report.daily_reports_medications.count
    @taken_medications = @daily_report.daily_reports_medications.where(taken: true).count

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

    def set_medication
      @medication = policy_scope(DailyReports::Medication).find(params[:id])
    end

    def medication_params
      params.require(:daily_reports_medication).permit(:taken)
    end
end
