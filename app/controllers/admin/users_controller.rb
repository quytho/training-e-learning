class Admin::UsersController < ApplicationController
  layout 'layouts/admin'
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "Delete success"
    redirect_to admin_users_path
  end
end
