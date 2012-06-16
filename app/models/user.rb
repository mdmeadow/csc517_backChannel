class User < ActiveRecord::Base
  set_primary_key :user_id
  attr_accessible :isAdmin, :password, :userName, :user_id
  validates :userName, :presence => true, :uniqueness => true
end
