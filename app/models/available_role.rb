class AvailableRole
  include Mongoid::Document

  belongs_to :site_role
  belongs_to :user

  def site_role_name
  	site_role.name
  end
end
