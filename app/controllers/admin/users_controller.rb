class Admin::UsersController < AdminController
  before_action :get_user, only:[:destroy]

  def index
    @users = User.order_name_user.paginate(page: params[:page], per_page: 10)
  end

  def destroy
    @user.destroy
    flash[:success] = "Delete success"
    redirect_to admin_users_path
  end

  private

    def get_user
      @user = User.find_by_id(params[:id])
      return if @user
      flash[:danger] = "User not found"
      redirect_to admin_users_path
    end
end
