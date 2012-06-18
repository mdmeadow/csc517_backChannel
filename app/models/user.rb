class User < ActiveRecord::Base
  attr_accessible :isAdmin, :password, :userName
  has_many :posts
  validates :userName, :presence => true, :uniqueness => true

  @current_user

  def setUser(name)
    @current_user = name
  end
end
