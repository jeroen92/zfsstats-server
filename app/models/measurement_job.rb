class MeasurementJob < Job
  include Mongoid::Document

  belongs_to :device
end
