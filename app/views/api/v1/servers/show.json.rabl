object @server
attributes :id, :name, :fqdn, :IPv4Address, :IPv6Address, :apiKey, :description, :created_at, :updated_at

child :devices do
	attributes :id, :guid, :name, :state, :capacity, :used, :type, :created_at, :updated_at
end

child :user do
	attributes :id, :email, :firstname, :lastname, :measurementInterval
end