class RelationshipsController < ApplicationController
  before_action :logged_in_user
  skip_before_action :verify_authenticity_token

  def create
    @user = User.find(params[:followed_id])
    if @user.blank?
      flash[:danger] = "User not found"
      redirect_to users_path
    end
    current_user.follow(@user)
    redirect_to @user
  end

  def destroy
    @user = User.find(params[:id])
    if @user.blank?
      flash[:danger] = "User not found"
      redirect_to users_path
    end
    current_user.unfollow(@user)
    redirect_to @user
  end
end
