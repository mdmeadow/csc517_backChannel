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
    @users = User.where("UPPER(username) LIKE UPPER(?) AND id NOT IN (SELECT user_id FROM posts)",
      "%#{params[:search]}%").order("created_at DESC")
    @posts = Post.joins(:user).where("UPPER(username) LIKE UPPER(?) OR UPPER(body) LIKE UPPER(?)",
      "%#{params[:search]}%", "%#{params[:search]}%").order("posts.created_at DESC")

    render "index"

  end
end

