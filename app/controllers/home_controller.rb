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
    upperSearch = params[:search].upcase
    @posts = Post.joins(:user).where("username LIKE UPPER(?) OR body LIKE UPPER(?)",
      "%#{upperSearch}%", "%#{upperSearch}%").order("posts.created_at DESC")

    render "index"

  end
end

