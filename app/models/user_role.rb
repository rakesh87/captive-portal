class UserRole
  def initialize(user)
    @user = user
  end

  def user_role
    return "super_admin" if @user.is_admin?
    @user.site_role.try(:name)
  end

  def super_admin?
  	@user.is_admin
  end

  def is_active?
    @user.is_active
  end

  def permitted_roles
    SiteRole.find(@user.available_roles.map(&:site_role_id)) rescue []
  end

  def role_pemissions_can_create
    @user.available_roles.collect(&:site_role_name)
  end

  def get_resources_and_permissions
    @user.site_role.site_accesses.where({"$or" => [{read: true}, {write: true}]}) if @user.site_role
  end
end