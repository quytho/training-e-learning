class CoursesController < ApplicationController
  before_action :get_course, only: [:show]

  def index
    @courses = Course.all
  end

  def show
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
