class User < ActiveRecord::Base
  attr_accessible :isAdmin, :password, :userName
  has_many :posts, :dependent => :delete_all
  validates :userName, :presence => true, :uniqueness => true
end
