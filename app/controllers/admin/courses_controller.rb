class Admin::CoursesController < ApplicationController
  layout 'layouts/admin'
  before_action :get_courseId, only:[:edit, :update, :destroy]

  def index
    @courses = Course.paginate(page: params[:page], per_page: 10)
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:success] = "Add success"
      redirect_to admin_courses_path
    else
      redirect_to  new_admin_course_path
    end
  end

  def edit
  end

  def update
    if @course.update course_params
      flash[:success] = "Profile updated"
      redirect_to admin_courses_path
    else
      render edit_admin_course_path
    end
  end

  def destroy
    @course.destroy
    flash[:success] = "Delete success"
    redirect_to admin_courses_path
  end

  private
    def course_params
      params.require(:course).permit(:name, :description)
    end

    def get_courseId
      @course = Course.find_by_id(params[:id])
      return if @course
      flash[:danger] = "User not found"
      redirect_to admin_courses_path
    end
end
