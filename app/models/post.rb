class Post < ActiveRecord::Base
  attr_accessible :body, :parent_id, :user_id
  belongs_to :parent, :class_name => 'Post', :foreign_key => 'parent_id'
  belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'
  validates :user_id, :presence => true
end

