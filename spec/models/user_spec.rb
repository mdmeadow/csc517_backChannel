require 'spec_helper'

describe User do
  before :each do
    @user = User.new
    @user.userName = "username"
    @user.password = "password"
    @user.isAdmin = true
  end

  it "should be a user" do
    @user.should be_an_instance_of User
  end

  it "validation for presence of userName" do
    @user2 = User.new
    @user2.password = "password"
    @user2.isAdmin = false
    @user2.save.should raise_error
  end

  it "validation for uniqueness of userName" do
    @user.save
    @user2 = User.new
    @user2.userName = "username"
    @user2.password = "password2"
    @user2.isAdmin = true
    @user2.save.should raise_error
  end

  it "dependent delete" do
    @user.save
    @post = Post.new
    @post.body = "body"
    @post.user_id = @user.id
    @post.save
    parent_id = Post.select("id").where(["body = ?", @post.body])

    @post2 = Post.new
    @post2.body = "body for second post"
    @post2.user_id = @user.id
    @post2.save

    @post3 = Post.new
    @post3.body = "body for reply for first post"
    @post3.parent_id = parent_id
    @post3.user_id = @user.id
    @post3.save

    Post.count.should == 3
    User.destroy(@user.id)
    Post.count.should == 0
  end
end
