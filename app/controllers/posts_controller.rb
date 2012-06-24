class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.select("posts.id, posts.body, posts.parent_id, posts.user_id, posts.created_at, count(children_posts.parent_id) as reply_count")
      .joins("left join posts as children_posts on posts.id = children_posts.parent_id").group("children_posts.parent_id").order("reply_count DESC")
    # .joins(:children).group("children_posts.parent_id").order("reply_count DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    id = params[:id]
    @post = Post.find(id)
    if (@post.parent_id != nil)
    id = @post.parent_id
    end
    @post = Post.find(id)
    @replies = Post.select("children_posts.id, children_posts.body, children_posts.parent_id, children_posts.user_id, children_posts.created_at")
      .joins(:children).where(["children_posts.parent_id = ?", id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html #{ redirect_to '/' }
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
 def edit
      @post = Post.find(params[:id])
    end

  # POST /posts
  # POST /posts.json
  def create
    # @post = Post.new(params[:post])
    @post = Post.new
    @post.body = params[:body]
    @post.user_id = params[:user_id]
    @post.parent_id = params[:parent_id]

    respond_to do |format|
      if !session[:user].nil?
        format.html { redirect_to @home, notice: 'Only users can post.' }
      elsif @post.save
        format.html { redirect_to "/", notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if !session[:user].nil?
        format.html { redirect_to @user, notice: 'Only users can post.' }
      elsif @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])

    respond_to do |format|
      if !session[:user].nil? && !session[:user].isadmin?
        format.html { redirect_to @user, notice: 'Only admins can delete.' }
      else
        @post.destroy
        format.html { redirect_to "/" }
        format.json { head :no_content }
      end
    end
  end
end
