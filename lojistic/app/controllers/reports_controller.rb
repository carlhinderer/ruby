class ReportsController < ApplicationController
  def index
    @reports = Report.where(:deleted => :false).all
  end

  def show
    @report = Report.find params[:id]
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    if @report.save
      flash[:notice] = "Report was successfully created. Currently being generated."
      redirect_to reports_path
    else
      render 'new'
    end
  end

  def destroy
    @report = Report.find params[:id]
    @report.soft_delete
    flash[:notice] = "Report was successfully deleted."
    redirect_to reports_path
  end

  private

  def report_params
    params.require(:report).permit(:report_type, :start_date, :end_date)
  end
end