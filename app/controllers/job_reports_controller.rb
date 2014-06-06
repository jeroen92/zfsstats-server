class JobReportsController < ApplicationController
  respond_to :json
  # GET /job_reports
  # GET /job_reports.xml
  def index
    @job_reports = JobReport.all
    respond_with(@job_reports)
  end

  # GET /job_reports/1
  # GET /job_reports/1.xml
  def show
    @job_report = JobReport.find(params[:id])
    respond_with(@job_report)
  end

  # GET /job_reports/new
  # GET /job_reports/new.xml
  def new
    @job_report = JobReport.new
    respond_with(@job_report)
  end

  # GET /job_reports/1/edit
  def edit
    @job_report = JobReport.find(params[:id])
  end

  # POST /job_reports
  # POST /job_reports.xml
  def create
    @job_report = JobReport.new(params[:job_report])
    flash[:notice] = 'JobReport was successfully created.' if @job_report.save
    respond_with(@job_report)
  end

  # PUT /job_reports/1
  # PUT /job_reports/1.xml
  def update
    @job_report = JobReport.find(params[:id])
    flash[:notice] = 'JobReport was successfully updated.' if @job_report.update_attributes(params[:job_report])
    respond_with(@job_report)
  end

  # DELETE /job_reports/1
  # DELETE /job_reports/1.xml
  def destroy
    @job_report = JobReport.find(params[:id])
    @job_report.destroy
    respond_with(@job_report)
  end
end
