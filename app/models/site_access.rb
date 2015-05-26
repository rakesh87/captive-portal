class SiteAccess
  include Mongoid::Document

  belongs_to :site_role

  field :access_for, type: String
  field :read, type: Boolean, default: false
  field :write, type: Boolean, default: false

  validates_presence_of :access_for


  RESOURCES = 
  	{
  		'users' => 'User',
  		'sites' => 'Site',
      'templates' => 'SiteTemplate',
      'vouchers' => 'Voucher',
      'sms_gateway' => 'SmsGatewayManagement',
      'radius_configuration' => 'RadiusConfiguration',
      'time_policy' => 'TimePolicy',
  		'guests' => 'GuestManagement',
      'analytics' => 'Analytic',
      'access_points' => 'AccessPoint',
      'reports' => 'Report'
    }

end
