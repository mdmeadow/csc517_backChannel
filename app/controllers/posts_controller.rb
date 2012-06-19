
class PostsController < ApplicationController
  @@searchedPosts = false

  # SEARCH
  def search
    respond_to do |format|
      format.html
    end
  end

  def search_submitted
    id = User.find_all_by_userName(:searchInfo)
    if id.empty?
      posts =  Post.where("body like '%?%'", :searchInfo)
    else
      posts = Post.where("body like '%?%' or user_id like ?", :searchInfo, id)
    end
    @posts = posts
    @@searchedPosts = true
    respond_to do |format|
      format.html { redirect_to :action => 'index'
      }
    end
  end

  # GET /posts
  # GET /posts.json
  def index
<<<<<<< HEAD
    if @@searchedPosts != true
      @posts = Post.select("posts.id, posts.body, posts.parent_id, posts.user_id, posts.created_at, count(*) as reply_count")
      .joins(:children).group("children_posts.parent_id").order("reply_count DESC")
    end
=======
    user_id = params[:userid]
    @posts = Post.where(["user_id = ? and parent_id is null", user_id])
    # @posts = Post.all
>>>>>>> parent of b9eec20... Corrected query to order by count of parent_ids in post controller.

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
    @@searchedPosts = false
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

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
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  def reply
    @post = Post.new

    respond_to do |format|
      format.html # reply.html.erb
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
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
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
      if @post.update_attributes(params[:post])
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
    @post.destroy

    respond_to do |format|
      format.html { redirect_to 'user_homepage' }
      format.json { head :no_content }
    end
  end
end
