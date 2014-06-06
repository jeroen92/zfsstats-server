class Specification
  include Mongoid::Document

  embedded_in :device

  field :name, type: String
  field :value, type: String

end
