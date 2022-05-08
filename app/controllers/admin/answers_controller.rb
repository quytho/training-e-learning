class Admin::AnswersController < AdminController
  before_action :get_question, only: [:new]
  before_action :get_answer, except: [:new, :create]

  def new
    @answer = Answer.new
    respond_to do |format|
      format.js {render 'new', layout: false}
    end
  end

  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      flash[:success] = "Add new answer success"
      redirect_to request.referrer
    else
      flash[:danger] = "Create answer fail"
      redirect_to request.referrer
    end
  end

  def edit
    respond_to do |format|
      format.js {render 'edit', layout: false}
    end
  end

  def update
    if @answer.update answer_params
      flash[:success] = "Update answer success"
      redirect_to request.referrer
    else
      flash[:danger] = "Update answer fail"
      redirect_to request.referrer
    end
  end

  def destroy
    if @answer.destroy
      flash[:success] = "Delete answer success"
      redirect_to request.referrer
    else
      flash[:danger] = "Delete answer fail"
      render admin_lessons_path
    end
  end

  private
    def answer_params
      params.require(:answer).permit(:answer, :question_id, :is_key)
    end

    def get_answer
      @answer = Answer.find_by_id(params[:id] || params[:answer][:answer_id] )
      if @answer.blank?
        flash[:danger] = "The answer is not available"
      end
    end

    def get_question
      @question = Question.find_by_id(params[:question_id])
      if @question.blank?
        flash[:danger] = "The question is not available"
        redirect_to admin_lessons_path
      end
    end
end
