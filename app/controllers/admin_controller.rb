class AdminController < ApplicationController
  before_action :check_permission, only: [:index]

  def index
    @user = User.count
    @course = Course.count
    @lesson = Lesson.count
    @word = Word.count
  end

  private
    def check_permission
      redirect_to login_path if current_user.blank?
    end
end
