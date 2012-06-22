class HomeController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index

    @backToIndex = false
    if (@posts == nil)
      @posts = Post.where("parent_id is null").sort_by{ |t| t.children.length }.reverse

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

