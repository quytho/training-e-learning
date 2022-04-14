class UsersController < ApplicationController
  before_action :get_user, only:[:show, :edit, :update]
  def index
    @users = User.paginate(page: params[:page], per_page: 15)
  end

  def new
    @user = User.new
  end
  
  def create 
    @user = User.new(user_params) 
    if @user.save
      log_in @user
      flash[:success] = "Success!"
      redirect_to user_path(@user)
    else 
      render :new
    end
  end

  def show 
  end

  def edit
  end

  def update
    if @user.update user_params
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private 
    def user_params 
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end

    def get_user
      @user = User.find_by_id(params[:id])
      return if @user
      flash[:danger] = "User not found"
      redirect_to root_path
    end
end
