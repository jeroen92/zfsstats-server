object @device
attributes :id, :guid, :name, :state, :type, :created_at, :updated_at

child :measurements do
	attributes :name, :created_at, :updated_at
	node(:id) { |o| o._id.to_s }
end

child :server do
	attributes :id, :name
end

child :specifications do
	attributes :name, :value
end

child :childs do
	attributes :guid, :name
end