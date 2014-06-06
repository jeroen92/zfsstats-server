object @measurement
attributes :id, :data, :name, :quantity, :is_string, :is_cumulative, :created_at, :updated_at
node(:id) { |o| o._id.to_s }

child :device do
	attributes :id
end