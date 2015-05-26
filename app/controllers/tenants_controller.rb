class TenantsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @tenants = Tenant.page params[:page]
  end

  def new
    @tenant = Tenant.new
  end

  def edit
    @tenant = Tenant.find(params[:id])
  end

  def create
    # role_permission_ids = params[:available_roles]
    @tenant = Tenant.new tenant_params
    @tenant.created_by = current_user.id
    respond_to do |format|
      if @tenant.save
        # role_permission_ids.each{|rp_id| @tenant.available_roles.create!(site_role_id: rp_id)}
        format.html { redirect_to tenants_path, notice: 'Tenant was successfully created.' }
      else
        format.html { render :new, alert: 'some error' }
      end
    end
  end

  def update
    # role_permission_ids = params[:available_roles]
    @tenant = Tenant.find(params[:id])
    respond_to do |format|
      if @tenant.update(tenant_params)
        format.html { redirect_to tenants_url, notice: 'Tenant was successfully updated.' }
      else
        format.html { render :edit, alert: 'some error' }
      end
    end
  end

  def permitted_roles
    @tenant = Tenant.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  private
    def tenant_params
      params.require(:tenant).permit(:name)
    end
end
