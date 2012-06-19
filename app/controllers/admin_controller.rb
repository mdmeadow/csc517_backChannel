class AdminController < ApplicationController
  # GET /admin
  # GET /admin.json
  def index
    @postsPerUser = Post.select("userName, count(*) as post_count")
      .joins(:user).group("userName").order("post_count DESC")

    @repliesPerPost = Post.select("posts.id, posts.body, posts.parent_id, userName, count(children_posts.parent_id) as reply_count")
      .joins("left join posts as children_posts on posts.id = children_posts.parent_id").joins(:user).group("children_posts.parent_id").order("reply_count DESC")

    @repliesPerPostForToday = Post.select("posts.id, posts.body, posts.parent_id, userName, count(children_posts.parent_id) as reply_count")
      .where(["DATE(posts.created_at) >= ?", Date.today])
      .joins("left join posts as children_posts on posts.id = children_posts.parent_id")
      .joins(:user).group("children_posts.parent_id").order("reply_count DESC")

    @postsPerDay = Post.select("DATE(created_at) as date, count(*) as post_count")
      .group("date").order("post_count DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end
end
