class RoomsController < ApplicationController
  def index
    @current_user = current_user
    redirect_to '/signin' unless @current_user
    @rooms = Room.public_rooms
    @users = User.all_except(@current_user)
    @room = Room.new
  end
  def show
    @current_user = current_user
    @single_room = Room.find(params[:id])
    @rooms = Room.public_rooms
    @users = User.all_except(@current_user)
    @room = Room.new
    @message = Message.new
    @messages = @single_room.messages
    render "index"
  end
  def new 
    @room = Room.new
  end
  def create
    @room = Room.new(name: params["room"]["name"])
    if @room.save
      flash[:success] = 'Success!'
      redirect_to request.referrer
    else
      flash[:warning] = 'Faild!'
    end
  end
end
