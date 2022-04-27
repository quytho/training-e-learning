class Admin::LessonsController < AdminController
  layout 'layouts/admin'

  def index
    @lessons = Lesson.order_name.paginate(page: params[:page], per_page: Settings.paginate)
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

  def destroy
    @lesson = Lesson.find_by_id(params[:id])
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
end
