require 'bcrypt'

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::MassAssignmentSecurity
  include BCrypt

  ROLES = %w[admin default]

  field :firstname, type: String
  field :lastname, type: String
  field :email, type: String
  field :password_hash, type: String
  field :role, type: String, default: 'default'
  field :lastLogin, type: DateTime

  field :measurementInterval, type: Integer, default: 60

  has_many :servers, :inverse_of => :user, :class_name => 'Server'

  attr_accessor :password, :password_confirmation
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_inclusion_of :role, in: ['default', 'admin']

  def update(params)
    puts params
    if(params[:password].nil? && params[:password_confirmation].nil?)
      raise "error"
      params.delete :password
      params.delete :password_confirmation
    end
    super(params)
  end
  
  def self.find_by_email(email)
  	where(:email => email).first
	end
  
  def self.authenticate(user_email, password)
    user = find_by_email user_email
    return if user.nil?
    user_pass = Password.new(user.password_hash)
    if user_pass == password
      user.lastLogin = DateTime.current()
      user.save()
    	return user
    else
    	return false
    end
  end

  def admin
    return true if self.role == 'admin'
    return false
  end
  
  protected
  
  def encrypt_password
    if password.present?
      self.password_hash = Password.create(@password)
    end
  end
end
