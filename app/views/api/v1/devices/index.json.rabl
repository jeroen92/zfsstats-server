collection @devices
attributes :id, :guid, :state, :name, :type, :IPv6Address, :apiKey, :description, :created_at, :updated_at

child :server do
	attributes :id
end