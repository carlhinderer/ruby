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

  def preview
    @invoices = Report.preview(start_date_from_params, end_date_from_params)
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

  def start_date_from_params
    date_from_params 'start_date'
  end

  def end_date_from_params
    date_from_params 'end_date'
  end

  def date_from_params(date_param)
    date_parts = report_params[date_param].split('-')
    Date.new(date_parts[0].to_i, date_parts[1].to_i, date_parts[2].to_i)
  end
end