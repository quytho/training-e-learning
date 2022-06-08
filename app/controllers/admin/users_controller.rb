module Admin
  class UsersController < AdminController
    skip_before_action :verify_authenticity_token
    before_action :take_user, except: %i[index new create]
    def index
      @users = User.order_name_user.paginate(page: params[:page], per_page: 10)
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        flash[:success] = "Create User successfully"
        redirect_to admin_users_path
      else
        flash[:warning] = "Create User failed"
        render :new
      end
    end

    def edit; end

    def destroy
      @user.destroy
      flash[:success] = 'Delete success'
      redirect_to admin_users_path
    end

    def update
      if @user.update(user_params)
        flash[:success] = "Updated user successfully"
      else
        flash[:warning] = "Update user failed"
      end
      redirect_to admin_users_path
    end
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :is_admin)
    end
    
    def take_user
      @user = User.find_by_id(params[:id])
      return if @user.present?

      flash[:danger] = 'User not found'
      redirect_to admin_users_path
    end
  end
end
