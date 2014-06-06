class Measurement
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String
  field :value, type: String                          # Holds the most actual value
  field :lastData, type: Array, :default => []        # Holds the most actual calculated value + timestamp
  field :lastValue, type: String                      # Holds the second most actual value
  field :quantity, type: String
  field :is_string, type: Boolean, :default => false
  field :is_cumulative, type: Boolean, :default => true

  belongs_to :device, :inverse_of => :measurement
  belongs_to :measurement_data, :class_name => "MeasurementData"


  def data
    self.measurement_data.data if measurement_data
  end

  def data=(msdata)
    if measurement_data.blank?
      self.measurement_data = MeasurementData.new
    end
    self.measurement_data.data = msdata unless msdata.blank?
  end

  after_initialize { |measurement|
    if (!(!!Float(measurement.value) rescue false))
      measurement.is_string = true
    end
  }

  before_save { |measurement|
    currentTime = Time.now.to_i
    # Substract previous value from current value.
    # Used for measurements that are always incremented in FE kstat (ARC hits/misses)
    if (measurement.is_string == false && measurement.is_cumulative == false)
      # If there is previous data, substract 2nd latest ms from latest ms
      if !measurement.lastValue.nil? && !measurement.value.nil?
        measurement.lastData = [(currentTime - currentTime % 60)*1000, Float(measurement.value) - Float(measurement.lastValue)]
      end
    elsif (!measurement.is_string)
      measurement.lastData = [(currentTime - currentTime % 60)*1000, Float(measurement.value)]
    else
      # If ms is static, just set the value.
      measurement.lastData = [(currentTime - currentTime % 60)*1000, measurement.value]
    end
    measurement.lastValue = measurement.value

    if (measurement.data)
      measurement.data.push(measurement.lastData)
    else
      measurement.data = measurement.lastData
    end
  }

  after_save { |measurement|
    measurement.measurement_data.save
  }
end