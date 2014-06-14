require 'ipaddr'
class Server
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :status

  before_create :generate_access_token

  field :_id, type: String, default: -> { name.to_s.parameterize }
  field :name, type: String
  field :fqdn, type: String
  field :IPv4Address, type: IPAddr
  field :IPv6Address, type: IPAddr
  field :apiKey, type: String
  field :description, type: String

  has_many :devices, dependent: :destroy
  has_many :jobs, dependent: :destroy

  belongs_to :user, :inverse_of => :servers, :class_name => 'User'

  validates_presence_of :name
  validate :name_not_changed

  def name=(name)
    write_attribute(:name, name)
    write_attribute(:_id, name)
  end

  def status
    status = 0
    self.devices.where(:type => 'zpool').all.each do |zpool|
      status += 1 if zpool.state != "ONLINE"
    end
    return status
  end

  private
    def generate_access_token
      self.apiKey = SecureRandom.hex
    end

    def name_not_changed
      if name_changed? && self.persisted?
        errors.add(:name, "Change of name is not allowed!")
      end
    end
end
