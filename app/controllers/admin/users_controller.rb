class Admin::UsersController < ApplicationController
  layout 'layouts/admin'
  def index
    @users = User.all
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end
end
