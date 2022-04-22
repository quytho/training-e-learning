class CoursesController < ApplicationController
  before_action :get_course, only: [:show, :words]
  def index
    @courses = Course.all
  end

  def show
  end

  def words
    if logged_in?
      @words = @course.words
      render :words
    else
      flash[:danger] = "Please login before viewing the list of words"
      redirect_to login_path
    end
  end
  
  private
    def get_course
      @course = Course.includes(:lessons)
        .find_by_id(params[:id])
      if @course.blank?
        flash[:danger] = "Could not found this course"
        redirect_to courses_path
      end
    end
end
