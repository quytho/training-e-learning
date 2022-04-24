class Admin::WordsController < AdminController
  before_action :get_word, only:[:edit, :update, :destroy]

  def index
    @words = Word.oder_by_name_word.paginate(page: params[:page], per_page: Settings.paginate)
  end

  def new
    @word = Word.new
    @courses = Course.all
    @lessons = Lesson.where(course_id: params[:course_id])
    if request.xhr?
      respond_to do |format|
        format.json {
          render json: {lessons: @lessons}
        }
      end
    end
  end

  def create
    @word = Word.new(word_params)
    if @word.save
      flash[:success] = "Add success"
      redirect_to admin_words_path
    else
      @lessons = Lesson.all
      flash[:danger] = "Add fail"
      render :new
    end
  end

  def edit
    @courses = Course.all
    @lessons = Lesson.where(course_id: params[:course_id])
    if request.xhr?
      format.json {
        render json: {lessons: @lessons}
      }
    end
  end

  def update
    if @word.update word_params
      flash[:success] = "Profile updated"
      redirect_to admin_words_path
    else
      flash[:danger] = "Profile update fail"
      render :edit
    end
  end

  def destroy
    if @word.destroy
      flash[:success] = "Delete success"
      redirect_to admin_words_path
    else
      flash[:danger] = "Delete fail"
      render admin_words_path
    end
  end

  private

  def word_params
    params.require(:word).permit(:en_word, :vi_word, :description, :lesson_id, :course_id)
  end

  def get_word
    @word = Word.find_by_id(params[:id])
    return if @word
    flash[:danger] = "Word not found"
    redirect_to admin_words_path
  end
end
