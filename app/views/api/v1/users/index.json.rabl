collection @users
attributes :firstname, :lastname, :email, :role, :lastLogin, :created_at, :updated_at
node(:id) { |o| o._id.to_s }