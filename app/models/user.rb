class User
  include Mongoid::Document

  field :first_name, type: String
  field :last_name, type: String
  field :birthday, type: Date
  field :address, type: String
end
