class NotificationsController < ApplicationController
  def index
  	@activities = 
  	if current_user.super_admin?
  		Kaminari.paginate_array(PublicActivity::Activity.order(:created_at => -1)).page(params[:page]).per(10)
  	else
  		PublicActivity::Activity.order(:created_at => -1).where(owner_id: current_user.id, owner_type: "User").limit(10)
  	end
  end
end
