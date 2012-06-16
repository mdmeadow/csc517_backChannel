class Post < ActiveRecord::Base
  belongs_to :parent, :class_name => 'Post', :foreign_key => 'parent_id'
  # belongs_to :user
  attr_accessible :body, :parent_id, :user_id
end
