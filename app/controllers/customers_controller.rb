class CustomersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def new
    @customer = current_user.user_partner_role.customers.new
    @user = User.new
  end

  def create
  	@customer = current_user.user_partner_role.customers.new customer_params
    @user = User.new users_params[:user]
    respond_to do |format|
      if @customer.save && @user.save
        @user.add_role Role::ROLES[:customer], @customer
        format.html { redirect_to root_url, notice: 'Partner customer was successfully created.' }
      else
        format.html { render :new, alert: 'some error' }
      end
    end
  end

  private

    def customer_params
      params.require(:customer).permit(:name, :partner_id)
    end

    def users_params
      params.require(:customer).permit(:user => [:email , :password])
    end
end
