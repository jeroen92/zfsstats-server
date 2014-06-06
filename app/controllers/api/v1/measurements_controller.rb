module Api
  module V1
    class MeasurementsController < ApiController
      respond_to :json

      # GET /measurements
      # GET /measurements.xml
      def index
        @measurements = Measurement.all
        @measurements = @measurements.where(:device_id => params[:device_id]) if params.has_key?(:device_id)
        @measurements = @measurements.where(:name => params[:name]) if params.has_key?(:name)
        @measurements = @measurements.where(:quantity => params[:quantity]) if params.has_key?(:quantity)
        respond_with(@measurements)
      end

      # GET /measurements/1
      # GET /measurements/1.xml
      def show
        @measurement = Measurement.find(params[:id])
        if params.has_key?(:start)
          startDate = DateTime.iso8601(params[:start]).to_i*1000
          # Traverse the array from end to start because it's more likely the start point lies closer to the current date than FE months ago.
          @measurement.data = @measurement.data.reverse_each.map{|d| d if (d[0] >= startDate)}.compact.reverse!
        end
        respond_with(@measurement)
      end

      # GET /measurements/new
      # GET /measurements/new.xml
      def new
        @measurement = Measurement.new
        respond_with(@measurement)
      end

      # GET /measurements/1/edit
      def edit
        @measurement = Measurement.find(params[:id])
      end

      # POST /measurements
      # POST /measurements.xml
      def create
        @measurement = Measurement.new(measurement_params)        
        if existing_ms = Measurement.where(name: @measurement.name, device_id: @measurement.device_id, quantity: @measurement.quantity).first
          existing_ms.value = @measurement.value
          existing_ms.save
        else
          if ["Hits", "Misses", "Read", "Write"].any? { |name| @measurement.name.include? name }
            @measurement.is_cumulative = false
          end
          @measurement.save
        end
        respond_to do |format|
          format.json { head :created }
        end
      end

      # PUT /measurements/1
      # PUT /measurements/1.xml
      def update
        @measurement = Measurement.find(params[:id])
        respond_with(@measurement)
      end

      # DELETE /measurements/1
      # DELETE /measurements/1.xml
      def destroy
        @measurement = Measurement.find(params[:id])
        @measurement.destroy
        respond_with(@measurement)
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def measurement_params
        params.permit(:name, :value, :quantity, :device_id)
      end
    end
  end
end