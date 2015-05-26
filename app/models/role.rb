class Role
  include Mongoid::Document

  has_and_belongs_to_many :users
  belongs_to :resource, :polymorphic => true
  belongs_to :site_role

  field :name, :type => String

  validates :name, presence: true

  index({
    :name => 1,
    :resource_type => 1,
    :resource_id => 1
  },
  { :unique => true})

  ROLES = {super_admin: 'super_admin'}

  # SiteRole.all.map{|site_role| ROLES.merge!(site_role.name.to_sym => site_role.name)}
  
  scopify
end
