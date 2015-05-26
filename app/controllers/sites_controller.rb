class SitesController < ApplicationController
  before_action :set_site, only: [:edit, :update, :destroy]
  load_and_authorize_resource

  respond_to :html

  def index
    @sites = current_user.super_admin? ? Site.all : current_user.tenant.sites
    respond_with(@sites)
  end

  def new
    @site = Site.new
    set_tenants if current_user.super_admin?
    respond_with(@site)
  end

  def edit
    set_tenants if current_user.super_admin?
  end

  def create
    @site = Site.new(site_params)
    if current_user.super_admin?
      set_tenants
    else
      @site.tenant_id = current_user.tenant_id
    end
    @site.save
    respond_to do |format|
      if @site.save
        format.html { redirect_to sites_path, notice: 'Site was successfully created.' }
        format.json { render :show, status: :created, location: @site }
      else
        format.html { render :new }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    set_tenants if current_user.super_admin?
    respond_to do |format|
      if @site.update(site_params)
        format.html { redirect_to sites_path, notice: 'Site was successfully updated.' }
        format.json { render :show, status: :created, location: @site }
      else
        format.html { render :edit }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @site.destroy
    redirect_to sites_path
  end

  private
    def set_site
      @site = Site.find(params[:id])
    end

    def site_params
      params.require(:site).permit(:name, :tenant)
    end

    def set_tenants
      @tenants = Tenant.all
    end
end
