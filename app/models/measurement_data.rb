class MeasurementData
  include Mongoid::Document
  include Mongoid::Timestamps

  field :data, type: Array

  has_one :measurement

  before_create { |measurement_data|
    measurement_data.data = []
  }
end
