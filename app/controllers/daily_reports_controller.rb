class DailyReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_daily_report, only: [ :show, :update ]

  def index
    @current_daily_report = current_user.daily_reports.where(report_date: Date.current).first
    @daily_reports = current_user.daily_reports.order(report_date: :desc)
    @pagy, @records = pagy(@daily_reports)
  end

  def show
  end

  def update
    respond_to do |format|
      if @daily_report.update(daily_report_params)
        format.html { redirect_to @daily_report, notice: "Daily report was successfully updated." }
        format.json { render :show, status: :ok, location: @daily_report }
      else
        format.html { render :edit }
        format.json { render json: @daily_report.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_daily_report
      @daily_report = current_user.daily_reports.find(params[:id])
    end
end
