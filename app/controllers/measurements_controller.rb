class MeasurementsController < ApplicationController

  respond_to :html, :json

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
    if (!!Float(@measurement.data) rescue false)
      @measurement.data = Float(@measurement.data)
    else
      @measurement.is_string = true
    end
    currentTime = Time.now.to_i
    @measurement.data = [(currentTime - currentTime % 60)*1000, @measurement.data]
    if existing_ms = Measurement.where(name: @measurement.name, device_id: @measurement.device_id, quantity: @measurement.quantity).first
      if existing_ms.data.any?
        if existing_ms.data.last[0] == @measurement.data[0]
          return
        end
      end
      existing_ms.data << @measurement.data
      existing_ms.save
      respond_with @measurement
    else
      words = ["Hits", "Misses", "Read", "Write"]
      if words.any? { |word| @measurement.name.include? word }
        @measurement.is_cumulative = false
      end
      @measurement.save
      respond_with @measurement
    end
  end

  # PUT /measurements/1
  # PUT /measurements/1.xml
  def update
    @measurement = Measurement.find(params[:id])
    flash[:notice] = 'Measurement was successfully updated.' if @measurement.update_attributes(params[:measurement])
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
    params.permit(:name, :data, :quantity, :device_id)
  end
end
