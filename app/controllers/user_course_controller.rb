class UserCourseController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @user_courses = UserCourse.create(user_course_params)
    flash[:success] = "Register Successfully"
    redirect_to request.referrer
  end

  private 
    def user_course_params 
      params.permit(:course_id, :user_id)
    end

end
