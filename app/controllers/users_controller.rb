class UsersController < ApplicationController
  before_action :fetch_user, except: %i[new create index chat]
  before_action :logged_in_user, except: %i[new create show]
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
      flash[:success] = 'Success!'
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def chat
    @user = User.find(params[:user_id])
    @current_user = current_user
    @rooms = Room.public_rooms
    @users = User.all_except(@current_user)
    @room = Room.new
    @message = Message.new
    @room_name = get_name(@user, @current_user)
    @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, @current_user], @room_name)
    @messages = @single_room.messages

    render "rooms/index"
  end

  def show
   
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render :edit
    end
  end

  def following
    @title = 'Following'
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
  def get_name(user1, user2)
    users = [user1, user2].sort
    "private_#{users[0].id}_#{users[1].id}"
  end
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end

  def fetch_user
    @user = User.find_by_id(params[:id])
    return if @user.present?

    flash[:danger] = 'User not found'
    redirect_to root_path
  end
end
