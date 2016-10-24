class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]


  before_action :require_user, only: [:index, :show]
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "ようこそ! BRAND へ #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your account Update!"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "ユーザーと記事が削除されました。"
    redirect_to users_path
  end

  def my_friends
    @friendships = current_user.friends
  end

  def add_friend
    @friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: @friend.id)

    if current_user.save
      flash[:success] = "友達追加に成功しました。"
      redirect_to my_friends_path


    else
      flash[:danger] = "エラーあり"
      redirect_to my_friends_path
    end
  end


  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user and !current_user.admin?
      flash[:danger] = "自身のアカウントのみ編集できます。"
      redirect_to root_path
    end
  end

  def require_admin
    if logged_in? and !current_user.admin?
      flash[:danger] = "管理者のみが実行できます。"
      redirect_to root_path
    end
  end

end


