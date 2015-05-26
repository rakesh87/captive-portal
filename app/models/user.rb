class User
  include Mongoid::Document
  include PublicActivity::Model
  extend Forwardable
  paginates_per 10

  tracked owner: Proc.new{ |controller, model| controller.current_user }, details: Proc.new{ |controller, model| model.changes }
  
  class << self
    def serialize_from_session(key, salt)
      record = to_adapter.get(key[0]["$oid"])
      record if record && record.authenticatable_salt == salt
    end
  end

  belongs_to :tenant
  belongs_to :site_role
  has_many :available_roles
  has_many :child_users, class_name: "User"
  belongs_to :parent_user, class_name: "User"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String
  field :is_admin,           type: Boolean, default: false
  field :is_active,          type: Boolean, default: true
  # field :parent_user_id

  validates_presence_of :tenant, :unless => Proc.new {|u| u.is_admin}
  validates_presence_of :site_role, :unless => Proc.new {|u| u.is_admin}

  scope :active_users, -> {where(is_active: true)}

  scope :except_super_admin, -> {where(is_admin: false)}

  def_delegators :user_role_object, :user_role, :super_admin?, :is_active?, :permitted_roles, :get_resources_and_permissions, :role_pemissions_can_create

  def user_role_object
    UserRole.new(self)
  end

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

end
