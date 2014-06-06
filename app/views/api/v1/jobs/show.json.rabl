object @job
attributes :status, :interval, :_type, :server_id, :report_status, :created_at, :updated_at
node(:id) { |o| o._id.to_s }

if root_object._type == 'MeasurementJob'
	attributes :device_id
end