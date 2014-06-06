module Api
  module V1
    class JobsController < ApiController
      respond_to :json
      # GET /jobs
      # GET /jobs.xml
      def index
        @jobs = Job.all
        @jobs = @jobs.where(server_id: params[:server_id]) if params.has_key?(:server_id)
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
        @job.update_attributes(params[:job])
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
  end
end