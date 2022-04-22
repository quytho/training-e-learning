class CoursesController < ApplicationController
  before_action :get_course, only: [:show, :words]
  def index
    @courses = Course.all
  end

  def show
  end

  def words
    @words = @course.words
    render 'words'
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
