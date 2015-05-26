class Tenant
  include Mongoid::Document
  include PublicActivity::Model
  paginates_per 10
  
  tracked owner: Proc.new{ |controller, model| controller.current_user }, details: Proc.new{ |controller, model| model.changes }
  
  has_many :customers
  has_many :users
  has_many :sites
  has_many :available_roles

  #accepts_nested_attributes_for :available_roles

  field :name, type: String
  field :created_by

  validates :name, presence: true

  def permitted_roles
    SiteRole.find(self.available_roles.map(&:site_role_id))
  end
end
