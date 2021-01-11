class PostsController < ApplicationController
  before_action :admin_user,{only: [:destroy]}
  before_action :ensure_correct_user , {only:[:edit,:update,:destroy]}
  before_action :authenticate_user,{only: [:show,:edit,:update,:destroy]}
  
  def index
    @posts = Post.all.order(created_at: :desc).page(params[:page])
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
    @likes_count = Like.where(post_id: @post.id).count
  end

  def create
    @post = Post.new(
      item_name: params[:item_name],
      place_name: params[:place_name],
      designer: params[:designer],
      user_id: @current_user.id ,
      image_name: params[:image]
    )

    if @post.save
      params[:image]
      @post.image_name = "#{@post.id}.jpg"
      image = params[:image]
      
      @post.save
      redirect_to("/posts/index")
      flash[:notice] = "投稿が完了しました"
    else
      render("posts/new")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.item_name = params[:item_name]
    @post.place_name = params[:place_name]
    @post.designer = params[:designer]
    
    if params[:image]
      @post.image_name = "#{@post.id}.jpg"
      image = params[:image]
      File.binwrite("public/post_images/#{@post.image_name}",image.read)
    end
    
    if @post.save
      redirect_to("/posts/#{@post.id}")
      flash[:notice] = "投稿内容を更新しました"
    else
      @error_message = "タイトルを入力してください"
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to("/posts/index")
    flash[:notice] = "投稿を削除しました。"
  end

  def admin_user
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to("/posts/index")
    flash[:notice] = "投稿を削除しました。"
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

end
