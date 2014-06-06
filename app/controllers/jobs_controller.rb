class JobsController < ApplicationController
  respond_to :html, :json
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  # GET /jobs
  # GET /jobs.xml
  def index
    jobs = Job.where(server_id: params[:server_id])
    respond_with(@jobs)
  end

  # GET /jobs/1
  # GET /jobs/1.xml
  def show
    @job = Job.find(params[:id])
    respond_with(@job)
  end

  # GET /jobs/new
  # GET /jobs/new.xml
  def new
    @job = Job.new
    @job.server_id = params[:server_id] if params[:server_id]
    respond_with(@job)
  end

  # GET /jobs/1/edit
  def edit
    @job = Job.find(params[:id])
  end

  # POST /jobs
  # POST /jobs.xml
  def create
    @job = Job.new(params[:job])
    flash[:notice] = 'Job was successfully created.' if @job.save
    respond_with(@job)
  end

  # PUT /jobs/1
  # PUT /jobs/1.xml
  def update
    @job = Job.find(params[:id])
    flash[:notice] = 'Job was successfully updated.' if @job.update_attributes(params[:job])
    respond_with(@job)
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.xml
  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    respond_with(@job)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end
end
