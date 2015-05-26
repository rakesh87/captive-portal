class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_users_collection
  before_action :set_user, only: [:show, :edit, :update, :destroy, :activate, :deactivate]
  load_and_authorize_resource

  def index
    @users = @users_collection.page params[:page]
  end

  def show; end

  def new
    @user = @users_collection.new
    set_roles_and_tenants
  end

  def edit
    @user = @users_collection.where(id: params[:id]).first
    set_roles_and_tenants
  end

  def create
    @user = @users_collection.new(user_params)
    @user.tenant = current_user.tenant if !current_user.super_admin?
    role_permission_ids = params[:available_roles]
    set_roles_and_tenants
    # if role_params[:roles].present?
      #TODO: Only one role object should be there for each tenant
      # site_role = SiteRole.find(role_params[:roles])
      # role = @user.add_role site_role.name, current_user.tenant
      # role.site_role_id = site_role.id
      # role.save
    # else
      # return render :new, alert: 'Please select a role.'
    # end
    site_ids = params[:site_ids]
    if site_ids.present?
      site_ids.each do |id|
        Site.where(id: id).first.update_attributes(tenant_id: @user.tenant_id)
      end
    end
    @user.parent_user_id = current_user._id
    respond_to do |format|
      if @user.save
        (role_permission_ids || []).each{|rp_id| @user.available_roles.create!(site_role_id: rp_id)}
        format.html { redirect_to users_url, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = @users_collection.where(id: params[:id]).first
    role_permission_ids = params[:available_roles]
    site_ids = params[:site_ids]
    if site_ids.present?
      site_ids.each do |id|
        Site.where(id: id).first.update_attributes(tenant_id: @user.tenant_id)
      end
    end
    if role_params[:roles].present?
      site_role = SiteRole.find(role_params[:roles])
      unless @user.roles.first.site_role == site_role
        role = @user.add_role site_role.name, current_user.tenant
        role.site_role_id = site_role.id
        role.save
      end
    end
    
    set_roles_and_tenants

    respond_to do |format|
      if @user.update(user_edit_params)
        @user.available_roles.destroy
        (role_permission_ids || []).each{|rp_id| @user.available_roles.create!(site_role_id: rp_id)}
        format.html { redirect_to users_url, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def activate
    @user.update_attribute(:is_active, true)
    redirect_to users_url, notice: 'User was successfully activated.'
  end

  def deactivate
    @user.update_attribute(:is_active, false)
    redirect_to users_url, notice: 'User was successfully deactivated.'
  end


  private

    def set_users_collection
      @users_collection = current_user.super_admin? ? User.except_super_admin : User.where(tenant_id: current_user.tenant.id, is_admin: false, :site_role_id.in => current_user.permitted_roles.map(&:id))
    end

    def set_user
      @user = @users_collection.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :tenant, :password_confirmation, :site_ids, :site_role_id)
    end

    def user_edit_params
      params.require(:user).permit(:name, :email, :tenant, :site_ids, :site_role_id)
    end

    def role_params
      params.require(:user).permit(:roles)
    end

    def set_roles_and_tenants
      if current_user.super_admin?
        @roles = SiteRole.all
      else
        @roles = current_user.permitted_roles
      end
      @tenants = Tenant.all if current_user.super_admin?
    end
end
