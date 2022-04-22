class AdminController < ApplicationController
  before_action :check_permission, only: [:index]

  def index
    @user_count = User.count
    @course_count = Course.count
    @lesson_count = Lesson.count
    @word_count = Word.count
  end

  private
    def check_permission
      redirect_to login_path if current_user.blank?
    end
end
