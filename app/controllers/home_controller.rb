class HomeController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index

  i = InitAdmin.new
    
    @backToIndex = false
    if (@posts == nil)
      # @posts = Post.select("posts.id, posts.body, posts.parent_id, posts.user_id, posts.created_at, count(children_posts.parent_id) as reply_count")
      # .joins("left join posts as children_posts on children_posts.parent_id = posts.id").group("children_posts.parent_id").order("reply_count DESC")
      @posts = Post.where("parent_id is null")
    else
      @backToIndex = true
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  def search
    @searchResult = true
    @posts = Post.select("posts.id, posts.body, posts.parent_id, posts.user_id, posts.created_at")
    .joins(:user).where("userName LIKE ? OR body LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%").order("posts.created_at DESC")

    render "index"

    # respond_to do |format|
      # format.html # index.html.erb
      # format.json { render json: @posts }
    # end
  end
end

class InitAdmin < ActiveRecord::Migration
  def self.up
    if Users.count("isAdmin = true") == 0
      user = User.create!( :isAdmin => 'true', :login => 'admin', :password => 'admin' )
    end
  end
end
