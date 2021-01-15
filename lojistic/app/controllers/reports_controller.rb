class ReportsController < ApplicationController
  def index
    @reports = Report.where(:deleted => :false).all
  end

  def destroy
    @report = Report.find params[:id]
    @report.soft_delete
    flash[:notice] = "Report was successfully deleted."
    redirect_to reports_path
  end
end