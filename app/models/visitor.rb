class Visitor
  include Mongoid::Document
  
  field :email, type: String
  field :name, type: String
  field :mac_id, type: String

  #index({ mac_id: 1 }, { unique: true, name: "visitor_index", background: true })
end
