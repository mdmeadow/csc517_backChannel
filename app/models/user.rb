class User < ActiveRecord::Base
  attr_accessible :isadmin, :password, :username
  has_many :posts, :dependent => :delete_all
  validates :username, :presence => true, :uniqueness => true
end
