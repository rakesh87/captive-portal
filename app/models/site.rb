class Site
  include Mongoid::Document
  include PublicActivity::Model
  paginates_per 10

  tracked owner: Proc.new{ |controller, model| controller.current_user }, details: Proc.new{ |controller, model| model.changes }

  belongs_to :tenant

  field :name, type: String

  validates :name, presence: true
  validates :tenant, presence: true
end
