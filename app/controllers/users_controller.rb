class UsersController < ApplicationController
  before_action :authenticate_user,{only: [:show,:edit,:update]}
  before_action :forbid_login_user,{only: [:new,:create,:login_page,:login]}
  before_action :ensure_correct_user,{only: [:edit,:update]}

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name] , 
      email: params[:email] ,
      password: params[:password] ,
      image_name: "default_user.jpg"
      )

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました。"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]
    @user.self_introduction = params[:self_introduction]
    
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}",image.read)
    end
    
    if @user.save
      redirect_to("/users/#{@user.id}")
      flash[:notice] = "アカウント情報を更新しました。"
    else
      render("users/edit")
    end
  end

  def login_page
  end

  def login
    @user = User.find_by(email: params[:email],password: params[:password])
      if @user
        session[:user_id] = @user.id
        redirect_to("/users/#{@user.id}")
        flash[:notice] = "ログインしました。"
      else
        @error_message = "メールアドレスまたはパスワードが間違っています"
        @email = params[:email]
        render("users/login_page")
      end
  end

  def logout
    session[:user_id] = nil
    redirect_to("/login")
    flash[:notice] = "ログアウトしました。"
  end

  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      redirect_to("/posts/index")
    end
  end

end
