class HomeController < ApplicationController
  before_filter :authenticate_user!
  #load_and_authorize_resource :class => Home 

  def index
  end

  def templates
    authorize! :read, SiteTemplate
  end

  def vouchers
    authorize! :read, Voucher
  end

  def analytics
    authorize! :read, Analytic
  end

  def radius_configurations
    authorize! :read, RadiusConfiguration
  end

  def access_points
    authorize! :read, AccessPoint
  end

  def reports
    authorize! :read, Report
  end

  def sms_gateway
    authorize! :read, SmsGatewayManagement
  end

  def time_policy
    authorize! :read, TimePolicy
  end

  def guests
    authorize! :read, GuestManagement
  end
end
