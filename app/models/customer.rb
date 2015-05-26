class Customer
  include Mongoid::Document
  field :name, type: String
  field :tenant_id
  
  belongs_to :tenant
end
