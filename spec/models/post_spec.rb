require 'spec_helper'

describe Post do
  #it "can be instantiated" do
  #  Post.new.should be_an_instance_of(Post)
  #end

  before :each do
    @post = Post.new
    @post.body = "body"
    @post.user_id = 1
  end

  it "should be a post" do
    @post.should be_an_instance_of Post
  end

  it "validation for presence of user_id" do
    @post2 = Post.new
    @post2.save.should raise_error
  end

  it "dependent delete" do
    @post.save
    @post2 = Post.new
    @post2.body = "body of reply"
    @post2.user_id = 2
    @post2.parent_id = @post.id
    @post2.save

    Post.count.should == 2
    Post.delete_all(["id = ? OR parent_id = ?", @post.id, @post.id])
    Post.count.should == 0
  end
end
