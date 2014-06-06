class JobReport
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String
  field :status, type: Integer, :default => 0
  
  belongs_to :job, dependent: :destroy
end
