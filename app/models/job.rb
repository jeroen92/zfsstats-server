class Job
  include Mongoid::Document
  include Mongoid::Timestamps

  field :status, type: Boolean, default: true
  field :interval, type: Integer

  has_many :job_reports, dependent: :destroy
  belongs_to :server

  # Shows if the client can collect new measurements.
  # Checks if there are measurement reports (completed jobs) between the current time and the current time minus the interval.
  # Rounds up seconds to next minute.
  def report_status
    return self.job_reports.where(:created_at.gt => (Time.now - (self.interval).seconds).change(:sec => 0) + (1).minutes).all.count > 0
  end
end
