class Admin::QuestionsController < AdminController
  layout 'layouts/admin'
  before_action :get_lesson, only: [:index]
  before_action :get_question, except: [:index, :create]

  def index
    @words = @lesson.words
    @question = Question.new
    @questions = Question.includes(:answers).where(lesson_id: @lesson.id)
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:success] = "Add new question success"
      redirect_to request.referrer
    else 
      flash[:danger] = "Create question fail"
      redirect_to request.referrer
    end
  end

  def edit
    respond_to do |format|
      format.js {render 'edit', layout: false}
    end
  end

  def update
    if @question.update question_params
      flash[:success] = "Update question success"
      redirect_to request.referrer
    else
      redirect_to admin_lessons_path
    end
  end

  def destroy
    if @question.destroy
      flash[:success] = "Delete question success"
      redirect_to request.referrer
    else
      flash[:danger] = "Delete question fail"
      render admin_lessons_path
    end
  end

  private
    def question_params
      params.require(:question).permit(:title, :lesson_id)
    end

    def get_lesson
      @lesson = Lesson.includes(:words, :questions).find_by_id(params[:lesson_id])
      if @lesson.blank?
        flash[:danger] = "The lesson is not available"
        redirect_to admin_lessons_path
      end
    end

    def get_question
      @question = Question.find_by_id(params[:id] || params[:question][:question_id] )
      if @question.blank?
        flash[:danger] = "The question is not available"
      end
    end
end
