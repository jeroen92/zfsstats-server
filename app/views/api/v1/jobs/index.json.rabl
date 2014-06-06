collection @jobs
attributes :status, :interval, :server_id, :_type, :created_at, :updated_at
node(:id) { |o| o._id.to_s }