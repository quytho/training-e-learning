class Admin::WordsController < ApplicationController
  layout 'layouts/admin'

  def index
  end

  def new
    @word = Word.new
    @courses = Course.all
    @lessons = []
    if params[:course_id].present?
      @lessons = Course.find(params[:course_id]).lessons
    end
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

  private

  def word_params
    params.require(:word).permit(:en_word, :vi_word, :description, :lesson_id, :course_id)
  end
end
