class DailyReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_daily_report, only: [ :show ]

  def index
    @current_daily_report = current_user.daily_reports.where(report_date: Date.current, is_template: false).first
    @daily_reports = current_user.daily_reports.where(is_template: false).order(report_date: :desc)
    @pagy, @records = pagy(@daily_reports)
  end

  def show
    @medications = @daily_report.daily_reports_medications.includes(:medication).order(:position)
    @total_medications = @medications.count
    @taken_medications = @medications.where(taken: true).count
  end

  private

    def set_daily_report
      @daily_report = policy_scope(DailyReport).find(params[:id])
    end
end
