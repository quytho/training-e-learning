class AdminController < ApplicationController
	before_action :get_user, only: [:show]
	def index
	end

	private
		def check_permission
			redirect_to login_path if current_user.blank?
		end
end
