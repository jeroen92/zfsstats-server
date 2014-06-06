collection @measurements
attributes :name, :quantity, :created_at, :updated_at
node(:id) { |o| o._id.to_s }

child :device do
	attributes :id
end