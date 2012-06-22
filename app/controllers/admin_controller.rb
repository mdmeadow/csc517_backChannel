class AdminController < ApplicationController
  # GET /admin
  # GET /admin.json
  def index
    @postsPerUser = Post.select('"userName", count(*) as post_count')
      .joins(:user).group('"userName"').order("post_count DESC")

    @repliesPerPost = Post.select('posts.id, posts.body, posts.parent_id, "userName"')
          .joins(:user).where("parent_id is null").sort_by{ |t| t.children.length }.reverse

    @repliesPerPostForToday = Post.select('posts.id, posts.body, posts.parent_id, "userName"')
          .joins(:user).where(["parent_id is null and DATE(posts.created_at) >= ?", Date.today]).sort_by{ |t| t.children.length }.reverse

    @postsPerDay = Post.select("DATE(created_at) as date, count(*) as post_count")
      .group("date").order("post_count DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end
end
