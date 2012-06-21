class UsersController < ApplicationController
  def authenticate
    current_un = params[:login_un]
    current_pw = params[:login_pw]
    @user = User.find_by_userName(current_un)

    if current_un.empty? || current_pw.empty? || @user.nil? ||
    @user.password != current_pw
      respond_to do |format|
        format.html { redirect_to action: "login" }
        flash[:notice] = "User Name/Password combination is incorrect."
      end
    else
      session[:user] = @user
      flash[:notice] = ""
      respond_to do |format|
      format.html { redirect_to :controller => 'home', :action => 'index' }
      end
    end
  end

  def login
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  def logout
    @user = nil
    session[:user] = nil
    respond_to do |format|
      format.html { redirect_to :controller => 'home', :action => 'index' }
    end
  end

  # GET /users
  # GET /users.json
  def index
    #@users = User.all
    @user = session[:user]
    @posts = Post.select("posts.id, posts.body, posts.parent_id, posts.user_id, posts.created_at, count(children_posts.parent_id) as reply_count")
    .joins("left join posts as children_posts on posts.id = children_posts.parent_id").group("children_posts.parent_id").order("reply_count DESC")
    respond_to do |format|
      format.html
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def show_all
    @users = User.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  def create_account
    username = params[:create_un]
    pw1 = params[:create_pw]
    pw2 = params[:confirm_pw]

    if username.empty? || pw1.empty? || pw2.empty?
      respond_to do |format|
        format.html { redirect_to action: "login" }
        flash[:creation_notice] = "All fields are required."
      end
    else
      if pw1 != pw2
        respond_to do |format|
          format.html { redirect_to action: "login" }
          flash[:creation_notice] = "Passwords must match."
        end
      else
        @user = User.find_by_userName(username)
        if @user.nil?

          @user = User.new
          @user.userName = username
          @user.password = pw1
          @user.isAdmin=false

          if @user.save
            session[:user] = @user
            respond_to do |format|
              format.html { redirect_to :controller => 'home', :action => 'index' }
              flash[:notice] = ""
            end
          else
            respond_to do |format|
              format.html { redirect_to action: "login" }
              flash[:creation_notice] = "Account was not created successfully."
            end
          end
        else
          respond_to do |format|
            format.html { redirect_to action: "login" }
            flash[:creation_notice] = "User Name is taken."
          end
        end
      end

    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { redirect_to action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_show_all }
      format.json { head :no_content }
    end
  end

  def delete_user
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to :action => 'show_all' }
      format.json { head :no_content }
    end
  end
end
