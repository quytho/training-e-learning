class WordsController < ApplicationController
  before_action :get_words, only: [:show]
  
  def show
  end
  
  private
    def get_words
      @lesson = Lesson.find_by_id(params[:lesson_id])
      if @lesson.present?
        return @lesson
      else
        flash[:danger] = "The lesson is not available"
        redirect_to courses_path
      end
    end
end
