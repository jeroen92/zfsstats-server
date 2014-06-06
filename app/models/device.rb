class Device
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :state, :capacity, :used

  field :_id, type: String, default: -> { guid.to_s.parameterize }
  field :guid, type: String
  field :name, type: String, default: nil
  field :type, type: String

  belongs_to :server, :inverse_of => :devices, :class_name => 'Server'

  has_many :childs, :class_name => 'Device', :inverse_of => :parent
  belongs_to :parent, :inverse_of => :childs, :class_name => 'Device'

  embeds_many :specifications, :class_name => 'Specification'
  accepts_nested_attributes_for :specifications
  has_many :measurements, :class_name => 'Measurement', dependent: :destroy

  has_one :measurement_job, dependent: :destroy

  after_create { |device| 
    if device.type.downcase == 'zfs'
      device.measurement_job = MeasurementJob.new(
        interval: device.server.user.measurementInterval,
        device_id: device._id,
        server_id: device.server_id)
      device.measurement_job.save
    end
  }

  after_find { |device|
    if device.type == 'zpool'
      device.specifications.any? { |spec|
        if spec.name == 'name'
          device.name = spec.value
        end
      }
    end
  }

  def capacity
    if self.type == 'zpool'
      return getLatestMeasurementValue('capacity')
    end
  end

  def state
    if self.type == 'zpool'
      return getLatestMeasurementValue('State')
    end
  end

  def used
    if self.type == 'zpool'
      return getLatestMeasurementValue('used')
    end
  end

  private
  def getLatestMeasurementValue(measurementName)
    if (measurement = self.measurements.where(name: measurementName)).exists?
      measurementDataId = measurement.pluck(:measurement_data_id).first
      measurementData = MeasurementData.slice(data: [-1, 1]).find(measurementDataId)
      return measurementData.data[0][1] if measurementData.data.size > 0
    end
  end

end

