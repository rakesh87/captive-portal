class SiteRolesController < ApplicationController
  before_action :set_site_role, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  
  respond_to :html

  def index
    @site_roles = SiteRole.page params[:page]
    respond_with(@site_roles)
  end

  def show
    respond_with(@site_role)
  end

  def new
    @selected_fields = {}
    @site_role = SiteRole.new
    respond_with(@site_role)
  end

  def edit
    @selected_fields = {}
    @site_role.site_accesses.each{ |sa| @selected_fields["#{sa.access_for}"] = [sa.read, sa.write]}
  end

  def create
    @site_role = SiteRole.new(name: params[:site_role][:name])
    params[:site_accesses].each do |sa|
      if sa.length > 1
        @site_role.site_accesses << @site_role.site_accesses.new(sa.permit(:access_for, :read, :write))
      end
    end
    respond_to do |format|
      if @site_role.save
        format.html { redirect_to site_roles_path, notice: 'Role was successfully created.' }
      else
        @selected_fields = {}
        @site_role.site_accesses.each{ |sa| @selected_fields["#{sa.access_for}"] = [sa.read, sa.write]}
        format.html { render :new, alert: 'some error' }
      end
    end
  end

  def update
    @site_role.site_accesses.delete_all
    @site_role.name = params[:site_role][:name]
    params[:site_accesses].each do |sa|
      if sa.length > 1
        @site_role.site_accesses << @site_role.site_accesses.new(sa.permit(:access_for, :read, :write))
      end
    end
    
    @site_role.save
    redirect_to site_roles_path
  end

  def destroy
    @site_role.destroy
    respond_with(@site_role)
  end

  private
    def set_site_role
      @site_role = SiteRole.find(params[:id])
    end

    def site_role_params
      params.require(:site_role).permit(:name, :site_accesses_attributes => [:read, :write, :access_for, :id])
    end
end
