class AdminController < ApplicationController
	before_action :check_permission, only: [:index]
	before_action :get_user, only: [:show]

	def index
	end
	def show
  end

	private
		def check_permission
			redirect_to login_path if current_user.blank?
		end

		def get_user
      @user = User.find_by_id(params[:id])
      return if @user
      flash[:danger] = "User not found"
      redirect_to admin_index_path
    end
end
