class User < ActiveRecord::Base
  set_primary_key :user_id
  attr_accessible :isAdmin, :password, :userName, :user_id
end
