class Admin::LessonsController < AdminController
  before_action :get_lesson, only:[:edit, :update, :destroy]

  def index
    @lessons = Lesson.order_name_lesson.paginate(page: params[:page], per_page: Settings.paginate)
  end

  def new
    @lesson = Lesson.new
    @courses = Course.all
  end

  def create
    @lesson = Lesson.new(lesson_params)
    if @lesson.save
      flash[:success] = "Add success"
      redirect_to admin_lessons_path
    else
      @courses = Course.all
      flash[:danger] = "Add fail"
      render :new
    end
  end

  def edit
    @courses = Course.all
  end

  def update
    if @lesson.update lesson_params
      flash[:success] = "Profile updated"
      redirect_to admin_lessons_path
    else
      flash[:danger] = "Profile update fail"
      render :edit
    end
  end

  def destroy
    if @lesson.destroy
      flash[:success] = "Delete success"
      redirect_to admin_lessons_path
    else
      flash[:danger] = "Delete fail"
      render admin_lessons_path
    end
  end

  private
    def lesson_params
      params.require(:lesson).permit(:name, :course_id)
    end

    def get_lesson
      @lesson = Lesson.find_by_id(params[:id])
      return if @lesson
      flash[:danger] = "User not found"
      redirect_to admin_lessons_path
    end
end
