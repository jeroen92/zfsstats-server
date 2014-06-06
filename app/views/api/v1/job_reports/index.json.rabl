collection @job_reports
attributes :status, :content, :job_id, :created_at, :updated_at
node(:id) { |o| o._id.to_s }