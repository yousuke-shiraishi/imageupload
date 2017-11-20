class BlogsController < ApplicationController
  before_action :login_validate, only: %i[new edit show]
  before_action :set_blog, only: %i[edit show update destroy]

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.all.order(updated_at: :desc)
    render layout: 'index.html.erb'
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  # GET /blogs/new
  def new
    if params[:back]
     @blog = Blog.new(blog_params)
     else
     @blog = Blog.new
     #@blog = current_user.blogs.build(blog_params)
    end
  end

  # GET /blogs/1/edit
  def edit; end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id # 現在ログインしているuserのidをblogのuser_idカラムに挿入する。
    BlogtoMailer.blogto_mail(@blog.user).deliver
    # 省略

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def confirm
    # @favorites_blogs= Blog.where(user_id: current_user.favorites)
    @favorites_blogs = current_user.favorite_blogs
    render layout: 'index.html.erb'
  end

  def check
    #@blog = Blog.new(blog_params)
    @blog = current_user.blogs.build(blog_params)
    render :new if @blog.invalid?
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_blog
    @blog = Blog.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def blog_params
    params.require(:blog).permit(:content)
  end

  def login_validate
    #  if !logged_in?
    #     redirect_to new_session_path
    if session[:user_id]
      begin
        @user = User.find(session[:user_id])
      rescue ActiveRecord::RecordNotFound
        reset_session
      end
    end
    redirect_to new_session_path unless @user
  end
end
