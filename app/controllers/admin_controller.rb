class AdminController < ApplicationController
	before_action :check_permission, only: [:index]
	def index
	end

	private
		def check_permission
			redirect_to login_path if current_user.blank?
		end
end
