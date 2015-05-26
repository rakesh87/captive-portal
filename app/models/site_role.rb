class SiteRole
  include Mongoid::Document
  include PublicActivity::Model
  paginates_per 10

  tracked owner: Proc.new{ |controller, model| controller.current_user }, details: Proc.new{ |controller, model| model.changes }
  
  has_many :site_accesses, dependent: :destroy
  has_many :available_roles, dependent: :destroy
  has_many :users
  
  accepts_nested_attributes_for :site_accesses

  field :name, type: String

  index({ name: 1 } , { unique: true })
  
  validates :name, presence: true
  validates_uniqueness_of :name
end
